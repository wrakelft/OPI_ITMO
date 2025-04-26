rm -rf svn_repo
rm -rf wc

svnadmin create svn_repo
REPO_URL="file:///C:/Users/gleb/OPI2/svn_repo"
echo "$REPO_URL"

cd svn_repo
svn mkdir -m "project structure" "$REPO_URL/trunk" "$REPO_URL/branches"
cd ..

svn checkout "$REPO_URL/trunk"/ wc # 0-7-11-14
cd wc

# r0 red
unzip -o ../commits/commit0.zip -d .
svn add * --force
svn commit -m "Initial commit (r0)" --username=red
echo "Revision 0 red"

svn copy "$REPO_URL/trunk" "$REPO_URL/branches/branch2" -m "Creating branch2" --username=blue # 1-5-6-13
svn switch "$REPO_URL/branches/branch2"

# r1 blue
unzip -o ../commits/commit1.zip -d .
svn add * --force
svn commit -m "r1 blue" --username=blue
echo "Revision 1 blue"

svn copy "$REPO_URL/trunk" "$REPO_URL/branches/branch3" -m "Creating branch3" # 2-3-4-8-9-10-12
svn switch "$REPO_URL/branches/branch3"

# r2 blue
unzip -o ../commits/commit2.zip -d .
svn add * --force
svn commit -m "r2 blue" --username=blue
echo "Revision 2 blue"

# r3 blue
unzip -o ../commits/commit3.zip -d .
svn add * --force
svn commit -m "r3 blue" --username=blue
echo "Revision 3 blue"

# r4 blue
unzip -o ../commits/commit4.zip -d .
svn add * --force
svn commit -m "r4 blue" --username=blue
echo "Revision 4 blue"

svn switch "$REPO_URL/branches/branch2"

# r5 blue
unzip -o ../commits/commit5.zip -d .
svn add * --force
svn commit -m "r5 blue" --username=blue
echo "Revision 5 blue"

# r6 blue
unzip -o ../commits/commit6.zip -d .
svn add * --force
svn commit -m "r6 blue" --username=blue
echo "Revision 6 blue"

svn switch "$REPO_URL/trunk"

# r7 red
unzip -o ../commits/commit7.zip -d .
svn add * --force
svn commit -m "r7 red" --username=red
echo "Revision 7 red"

svn switch "$REPO_URL/branches/branch3"

# r8 blue
unzip -o ../commits/commit8.zip -d .
svn add * --force
svn commit -m "r8 blue" --username=blue
echo "Revision 8 blue"

# r9 blue
unzip -o ../commits/commit9.zip -d .
svn add * --force
svn commit -m "r9 blue" --username=blue
echo "Revision 9 blue"

# r10 blue
unzip -o ../commits/commit10.zip -d .
svn add * --force
svn commit -m "r10 blue" --username=blue
echo "Revision 10 blue"

svn switch "$REPO_URL/trunk"

# r11 red
unzip -o ../commits/commit11.zip -d .
svn add * --force
svn commit -m "r11 red" --username=red
echo "Revision 11 red"

svn switch "$REPO_URL/branches/branch3"

# r12 blue
unzip -o ../commits/commit12.zip -d .
svn add * --force
svn commit -m "r12 blue" --username=blue
echo "Revision 12 blue"

svn update
svn switch "$REPO_URL/branches/branch2"

svn merge "$REPO_URL/branches/branch3"
##
## ИСПРАВЛЕНИЕ КОНФЛИКТА ВРУЧНУЮ
##
svn add * --force
echo "Слияние r6 и r12"

# r13 blue
unzip -o ../commits/commit13.zip -d .
svn add * --force
svn commit -m "r13 blue" --username=blue
echo "Revision 13 blue"

svn update
svn switch "$REPO_URL/trunk"

svn merge "$REPO_URL/branches/branch2"
##
## ИСПРАВЛЕНИЕ КОНФЛИКТА ВРУЧНУЮ
##
svn add * --force
echo "Слияние r11 и r13"

# r14 red
unzip -o ../commits/commit14.zip -d .
svn add * --force
svn commit -m "r14 red" --username=red
echo "Revision 14 red"

svn update