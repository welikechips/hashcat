
#!/bin/bash
lookingfor=136
starting="$(cat /var/log/apache2/*| grep $lookingfor| grep jpg| wc -l | cut -d ' ' -f1)"
while true; do
lines="$(cat /var/log/apache2/*| grep $lookingfor| grep jpg| wc -l | cut -d ' ' -f1)"
ip="$(cat /var/log/apache2/*| grep $lookingfor| grep jpg| tail -n 2| cut -d '"' -f1| sort -u)"
gotone="$(cat /var/log/apache2/access*| tail -n 1| sed -r 's/"//g')"
        if [[ $lines -gt $starting ]];then
                curl -X POST -H 'Content-type: application/json' \
                https://hooks.slack.com/services/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 \
                --data @<(cat <<EOF
                {
                 "text": "$gotone"
                 }
EOF
                )
        #       echo $gotone
                starting=$((starting+1))
        fi
done
