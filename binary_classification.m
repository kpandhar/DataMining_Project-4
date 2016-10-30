function []= binary_classification(questionNum)
    classMatrix=[];
    display('Running KNN for HumanActivityRecog dataset: Question 1');
    training_data = dlmread('./Dataset/HumanActivityRecog/X_train.txt');
    test_data = dlmread('./Dataset/HumanActivityRecog/X_test.txt');
    training_class = dlmread('./Dataset/HumanActivityRecog/y_train.txt');
    test_class = dlmread('./Dataset/HumanActivityRecog/y_test.txt');