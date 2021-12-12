#!/usr/bin/python3

import mysql.connector

conn = mysql.connector.connect(user='pro', password='',
                              host='db',database='final')

if conn:
    print ("Connected Successfully")
else:
    print ("Connection Not Established")

#select_table = """SELECT * FROM Articles order by id"""
select_table = """select author.author AS 'Author', magazines.name AS 'Magazine name', article_types.type AS 'Article type' from Articles INNER JOIN author ON Articles.author_id=author.id INNER JOIN magazines ON Articles.magazines_id=magazines.id INNER JOIN article_types ON Articles.article_type_id=article_types.id"""
cursor = conn.cursor()
cursor.execute(select_table)
result = cursor.fetchall()
colname = cursor.description
p = '<tr>'

for row1 in colname:
   p += f'<td>{row1[0]}</td>'
p += '</tr>'


for row in result:
  p += f"<tr>"
  for col in row:
    p += f"<td>{col}</td>"
  p += f"</tr>"


contents = '''<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>FINAL TASK PYTHON SCRIPT</title>
</head>
<style> table, th, td {
    border:1px solid black; 
    border-collapse: collapse;
    border-style:dashed;
    border-color: #96D4D4;
}
td {
    text-align: center;
}
</style>
<body>
<table>
%s
</table>
</body>
</html>
'''%(p)

filename = '/home/web/db.html'

def main(contents, filename):
    output = open(filename,"w")
    output.write(contents)
    output.close()

main(contents, filename)    

if(conn.is_connected()):
    cursor.close()
    conn.close()
    print("MySQL connection is closed.") 
