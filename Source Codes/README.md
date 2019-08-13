## Please consider the following steps to generate these source codes
To have a practical example, the source code is explained using the seed dataset.


1. Download all the provide files in this folder and perform the following steps.[You can use the provided .mat files to run the main file in section 4]

2. Loading the data
  
    - Data should load in the form of Seeds.m
    - dataset.samples includes the features
    - dataset.classes contains the coresponding labels

3. Prepration of data for 10-fold cross-validation strategy

    - Preprocessing_Ten_Fold.m partitions data into 10 disjoint folds.
    - Please recall that set "DataSetName" variable to the desired name. For example, this variable is set to 'Seeds' in the uploaded code.
    - This program will add "-10-fold" to the provided name in the DataSetName. In the example file, the output file name is "Seeds-10-fold".
  
4. Run the main source code
    - ASVDD.m is the main matlab file that contains the ASVDD program. Please adjust the following variables before running this file:
        - load the adjusted dataset created in the previous step. In the uploaded file, it is set as "Seeds-10-fold"
        - Please recall that set "DataSetName" variable to the desired name. For example, this variable is set to 'Seeds' in the uploaded code.
        - Please set the TargetClasse to your desired target class. ASVDD is a one class classifier that tries to put an optimized hypersphere around the target data. In the example, it look at the class 3.
        - It is worth mentioning that this file trains the ASVDD based on 9-folds and test based on the remaining fold by "SVDD_Metaheuristic_C_Sigma_Membership" and "SVDD_Metaheuristic_Test".
        - Finally, "%% Check target classe samples existe in Training ones" section double checks all created 10-folds to guarantee that there is at leaset one sample from the tareget class in all folds. SVDD is a one class classifer therefore it needs the target class for both training and testing the created classifier.
