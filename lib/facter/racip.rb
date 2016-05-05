# racip.rb
Facter.add(:racip) do
 setcode do
  hname = Facter.value(:hostname)
  hname = hname.chop
  ipadd = {}
  names = ['0','1','2','3','4','a','b','c','d','e','f','1-priv','2-priv','3-priv','4-priv','a-priv','b-priv','c-priv','d-priv','e-priv','f-priv','1-vip','2-vip','3-vip','4-vip','a-vip','b-vip','c-vip','d-vip','e-vip','f-vip']
  names.each do |h| 
   new_name = (hname + h)
   entry = `getent hosts #{new_name}|awk '{print $1}'`
   if entry.length > 0
     ipadd[new_name] = entry
   end
  end
  ipadd.invert
 end
end
