from sys import argv
from headers import forwardHeaders
from headers import reverseHeaders
from headers import forwardZone
from headers import reverseZone

namedConfFile = open('named.conf.local', 'a')

class Network(object):
	def __init__(self, networkAddress):
		address, m = networkAddress.split("/")
		self.mask = int(m)
		self.octects = [int(octect) for octect in address.split(".")]
	def __string__(self):
		return "{0}/{1}".format(str.join(".", self.octects), self.mask)
	def address(self):
		return self._forwardIp(self.octects[0], self.octects[1], self.octects[2], self.octects[3])
	def reverseAddress(self):
		return self._reverseIp(self.octects[0], self.octects[1], self.octects[2], self.octects[3])
	def forwardHosts(self):
		return self._hosts(self._forwardIp)
	def reverseHosts(self):
		return self._hosts(self._reverseIp)
	def _hosts(self, order):
		addresses = 2 ** (32 - self.mask) - 2
		for i in range(1, addresses + 1):
			firstOctetSum = i / 2**24
			secondOctetSum = (i - firstOctetSum * (2**24)) / 2**16
			thirdOctetSum = (i - firstOctetSum * (2**24) - secondOctetSum * (2**16)) / 2**8
			fourthOctetSum = (i - firstOctetSum * (2**24) - secondOctetSum * (2**16) - thirdOctetSum * (2**8))
			firstOctet = self.octects[0] + firstOctetSum
			secondOctet = self.octects[1] + secondOctetSum
			thirdOctet = self.octects[2] + thirdOctetSum
			fourthOctet = self.octects[3] + fourthOctetSum		
			yield order(firstOctet, secondOctet, thirdOctet, fourthOctet)
	def _reverseIp(self, firstOctet, secondOctet, thirdOctet, fourthOctet):
		return "{0}.{1}.{2}.{3}".format(fourthOctet, thirdOctet, secondOctet, firstOctet)
	def _forwardIp(self, firstOctet, secondOctet, thirdOctet, fourthOctet):
		return "{0}.{1}.{2}.{3}".format(firstOctet, secondOctet, thirdOctet, fourthOctet)


def main():
	if (len(argv) != 2):
		print "Error, provide a subdomain for the files"
		return
	subdomain = argv[1]
	if (subdomain not in forwardHeaders):
		print "Error: the subdomain does not exist. Use rioturbio, riogallegos or elcalafate"
		return	
	inFileName = '{0}.networks'.format(subdomain)
	outFwdFileName = 'db.{0}.stacruz.dc.fi.uba.ar'.format(subdomain)
	networksFile = open(inFileName, 'r')
	fwdFile = open(outFwdFileName, 'w')
	fwdFile.write(forwardHeaders[subdomain])
	for networkEntry in networksFile:
		name, subd, networkAddress = networkEntry.rstrip().split(";")
		generateReverseRules(name, subd, networkAddress)
		for rule in generateForwardRules(name, subd, networkAddress):
			fwdFile.write(rule + '\n')
	namedConfFile.write(forwardZone.format(subdomain))

def generateForwardRules(name, subdomain, networkAddress):
	net = Network(networkAddress)
	cont = 1
	for h in net.forwardHosts():		
		machineId = name + (str(cont) if cont > 9 else '0' + str(cont))
		yield "{0}.{1}.stacruz.dc.fi.uba.ar. IN A {2}".format(machineId, subdomain, h)		
		cont += 1

def generateReverseRules(name, subdomain, networkAddress):
	rules = []
	net = Network(networkAddress)
	cont = 1
	fileNameFormat = "db.{0}"
	reverseHeader = reverseHeaders[subdomain]
	forwardPartialAddress = str.join(".", net.address().split(".")[:-1])
	reverseAddressParts = net.reverseAddress().split(".")
	if (net.mask > 24):
		reverseAddressParts[0] = reverseAddressParts[0] + "/" + str(net.mask)
	reversePartialAddress = str.join(".", reverseAddressParts[(1 if net.mask == 24 else 0):])
	fileName = fileNameFormat.format(forwardPartialAddress if net.mask == 24 else networkAddress.replace("/", "-"))
	rulesFile = open(fileName, 'w')
	rulesFile.write(reverseHeader.format(reversePartialAddress))
	for h in net.reverseHosts():
		machineId = name + (str(cont) if cont > 9 else '0' + str(cont))
		if (net.mask == 24):
			rulesFile.write("{2}.in-addr.arpa. IN PTR {0}.{1}.stacruz.dc.fi.uba.ar.".format(machineId, subdomain, h) + '\n')
		else:
			rulesFile.write("{2}.in-addr.arpa. IN PTR {0}.{1}.stacruz.dc.fi.uba.ar.".format(machineId, subdomain, h.split(".")[0] + "." + reversePartialAddress) + '\n')
		cont += 1
	rulesFile.close()
	namedConfFile.write(reverseZone.format(reversePartialAddress, fileName) + '\n')

main()
