#!/bin/bash
p=$(cat /home/db/pass)
mysql -u pro -p"$p" -D final -e "select author.author AS 'Author', magazines.name AS 'Magazine name', article_types.type AS 'Article type' from Articles INNER JOIN author ON Articles.author_id=author.id INNER JOIN magazines ON Articles.magazines_id=magazines.id INNER JOIN article_types ON Articles.article_type_id=article_types.id;" > /local/files/Articles_$(date +%y%m%d-%H%M%S)
countf=$(ls -la /local/files | grep Art | wc -l)
if [ $countf -gt 3 ]
then 
   tar -cvf /local/backups/Articles_Archive_$(date +%y%m%d-%H%M%S).tar /local/files/Articles_*
   rm -rf /local/files/Articles_*
fi 
