# Junit Compile and Run Variables
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
CPATH1=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"
CPATH2=".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar"

# Remove old repository and clone new one
rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

# Change directory to cloned repo
cd student-submission

# Check if submission contains file to check
if [[ -f ListExamples.java ]]
then
    echo "ListExamples.java found."
else
    echo "File not found."
    exit 1
fi

# Copy tests and library to repo directory
cp ../TestListExamples.java .
mkdir lib
cp -R ../lib .

# Compile Test
javac -cp $CPATH1 *.java

if [[ $? == 0 ]]
then
    echo "Compile success."
else
    echo "Compile failure."
    exit 1
fi

# Run Tests
java -cp $CPATH2 org.junit.runner.JUnitCore TestListExamples > TestResults.txt

if [[ $? == 0 ]]
then
    echo "Run success."
else
    echo "Run failure."
fi

# Display results of test
grep "Tests" TestResults.txt
