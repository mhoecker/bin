#/bin/sh
BASENAME=gitdot
echo 'digraph test{' > $BASENAME.dot
git log  --pretty=" %H"\
|\sed -e "s/0/q/g" -e "s/1/r/g" -e "s/2/s/g" -e "s/3/t/g" -e "s/4/u/g" -e "s/5/v/g" -e "s/6/w/g" -e "s/7/x/g" -e "s/8/y/g" -e "s/9/z/g"\
>>$BASENAME.dot1
git log  --pretty="[label=\"%d\n%s\n%aD\",fontsize=12];" >> $BASENAME.dot2
paste $BASENAME.dot1 $BASENAME.dot2 >> $BASENAME.dot
rm $BASENAME.dot?
git log  --pretty=" {%P} -> %H;" | \
sed -e "s/0/q/g" -e "s/1/r/g" -e "s/2/s/g" -e "s/3/t/g" -e "s/4/u/g" -e "s/5/v/g" -e "s/6/w/g" -e "s/7/x/g" -e "s/8/y/g" -e "s/9/z/g"  -e "s/{}/{Root}/g">>$BASENAME.dot
echo "}">>$BASENAME.dot
dot -Tpng $BASENAME.dot -o $BASENAME.png
dot -Tsvg $BASENAME.dot -o $BASENAME.svg
