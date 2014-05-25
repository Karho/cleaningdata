###Files used:

- 'run_analysis.R': Principal script (See usage below)

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

###Outputs:
- result/cmall.txt

- result/mall.txt

- result/tidy_mall.txt


###Usage 'run_analysis.R':

1º Setup your directory in the first line of 'run_analysis.R' script

2º run 'run_analysis.R'

###Transformations

1º Getting parametrers

2º Load data from sources until end.(I need chunks of 100 lines). So you must use N_ROWS.

3º Merging data from "test" and "train" forming the new data set "mall"

4º Extracting columns with "mean" and "std" patterns forming the new data set "cmall"

5º Addind descriptions of Activities to "cmall"

6º Tidy the new aggregated data set called "tidy_mall"

7º Writting data sets output
