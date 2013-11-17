elCalafateHeader = '''$TTL 3h
elcalafate.stacruz.dc.fi.uba.ar. IN SOA bh01.rioturbio.stacruz.dc.fi.uba.ar. admin.stacruz.dc.fi.uba.ar. (
		1 ;  Serial
		3h ;  Refresh after 3 hours
		1h ;  Retry after 1 hour
		1w ;  Expire after 1 week
		1h ) ;  Negative caching TTL of 1 day
elcalafate.stacruz.dc.fi.uba.ar. IN NS bh01.rioturbio.stacruz.dc.fi.uba.ar.
;Host addresses
'''

rioTurbioHeader = '''$TTL 3h
rioturbio.stacruz.dc.fi.uba.ar. IN SOA trek06.rioturbio.stacruz.dc.fi.uba.ar. admin.stacruz.dc.fi.uba.ar. (
		1 ;  Serial
		3h ;  Refresh after 3 hours
		1h ;  Retry after 1 hour
		1w ;  Expire after 1 week
		1h ) ;  Negative caching TTL of 1 day
rioturbio.stacruz.dc.fi.uba.ar. IN NS trek06.rioturbio.stacruz.dc.fi.uba.ar.
;Host addresses
'''

rioGallegosHeader = '''$TTL 3h
riogallegos.stacruz.dc.fi.uba.ar. IN SOA bh01.riogallegos.stacruz.dc.fi.uba.ar. admin.stacruz.dc.fi.uba.ar. (
		1 ;  Serial
		3h ;  Refresh after 3 hours
		1h ;  Retry after 1 hour
		1w ;  Expire after 1 week
		1h ) ;  Negative caching TTL of 1 day
riogallegos.stacruz.dc.fi.uba.ar. IN NS bh01.riogallegos.stacruz.dc.fi.uba.ar.
;Host addresses
'''

rioGallegosReverseHeader = '''$TTL 3h
{0}.in-addr.arpa. IN SOA bh01.riogallegos.stacruz.dc.fi.uba.ar. admin.stacruz.dc.fi.uba.ar. (
		1 ;  Serial
		3h ;  Refresh after 3 hours
		1h ;  Retry after 1 hour
		1w ;  Expire after 1 week
		1h ) ;  Negative caching TTL of 1 hour
; name servers
{0}.in-addr.arpa. IN NS bh01.riogallegos.stacruz.dc.fi.uba.ar.
; addresses
'''

rioTurbioReverseHeader = '''$TTL 3h
{0}.in-addr.arpa. IN SOA trek06.rioturbio.stacruz.dc.fi.uba.ar. admin.stacruz.dc.fi.uba.ar. (
		1 ;  Serial
		3h ;  Refresh after 3 hours
		1h ;  Retry after 1 hour
		1w ;  Expire after 1 week
		1h ) ;  Negative caching TTL of 1 hour
; name servers
{0}.in-addr.arpa. IN NS trek06.rioturbio.stacruz.dc.fi.uba.ar.
; addresses
'''

elCalafateReverseHeader = '''$TTL 3h
{0}.in-addr.arpa. IN SOA bh01.rioturbio.stacruz.dc.fi.uba.ar. admin.stacruz.dc.fi.uba.ar. (
		1 ;  Serial
		3h ;  Refresh after 3 hours
		1h ;  Retry after 1 hour
		1w ;  Expire after 1 week
		1h ) ;  Negative caching TTL of 1 hour
; name servers
{0}.in-addr.arpa. IN NS bh01.rioturbio.stacruz.dc.fi.uba.ar.
; addresses
'''

forwardZone = '''zone "{0}.stacruz.dc.fi.uba.ar" {{
	type master;
	file "/etc/bind/db.{0}.stacruz.dc.fi.uba.ar";
}};
'''

reverseZone = """zone "{0}.in-addr.arpa" {{
	type master;
	file "/etc/bind/{1}";
}};
"""


forwardHeaders = {}
forwardHeaders["elcalafate"] = elCalafateHeader
forwardHeaders["rioturbio"] = rioTurbioHeader
forwardHeaders["riogallegos"] = rioGallegosHeader

reverseHeaders = {}
reverseHeaders["elcalafate"] = elCalafateReverseHeader
reverseHeaders["rioturbio"] = rioTurbioReverseHeader
reverseHeaders["riogallegos"] = rioGallegosReverseHeader
