#!/bin/bash

# http://gameinfo.na.leagueoflegends.com/en/game-info/items/
# http://ddragon.leagueoflegends.com/cdn/6.4.2/data/en_US/item.json

# http://ddragon.leagueoflegends.com/cdn/6.4.2/img/item/1053.png
f_prefix='http://ddragon.leagueoflegends.com/cdn/6.4.2/img/item'

# http://ddragon.leagueoflegends.com/cdn/6.4.2/img/sprite/item0.png
s_prefix='http://ddragon.leagueoflegends.com/cdn/6.4.2/img/sprite'

folder='item'

rm -fr "${folder}" && mkdir -pv "${folder}"
jq -c '.data | to_entries | .[] | {id:.key,f:.value.image.full,s:.value.image.sprite}' item.json \
| while read line
do
	id=$(echo ${line} | jq '.id' | sed 's/\"//g')
	f=$(echo ${line} | jq '.f' | sed 's/\"//g')
	s=$(echo ${line} | jq '.s' | sed 's/\"//g')
	wget ${f_prefix}/${f} -O ${folder}/${f}
	# wget ${s_prefix}/${s} -O ${folder}/${s}
done