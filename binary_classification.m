function []= binary_classification()
    display('Question 1');
%     Getting training and test data from database
    training_data = getfield(load('./Dataset/VidTIMIT_Data/X_train.mat'), 'X_train');
    training_class = transpose(getfield(load('./Dataset/VidTIMIT_Data/y_train.mat'),'y_train'));
    test_data = getfield(load('./Dataset/VidTIMIT_Data/X_test.mat'),'X_test');
    test_class = transpose(getfield(load('./Dataset/VidTIMIT_Data/y_test.mat'),'y_test'));
    
%     Needed data to train and test
    rows_test = size(test_data,1);
    unique_classes=unique(training_class);
    total_unique_classes=length(unique_classes);
    
%     Training the SVMs for VidTIMIT traning dataset, using fitcsvm
    display('Training models for VidTIMIT traning dataset');
    for class=1:total_unique_classes
        class_index = eq(training_class,unique_classes(class));
        SVMModels{class} = fitcsvm(training_data,class_index,'KernelFunction','polynomial','PolynomialOrder',2);

%         Testing VidTIMIT test dataset, using predict
        disp(sprintf('Testing SVM for binary classification of test dataset for CLASS: %d ',class));
        [label,score,cost] = predict(SVMModels{class},test_data);
        
%         Making a final array that stores class label for every observation in test dataset
        for k=1:rows_test
            if label(k)==1
                final_label(k,1)= class;
            end
        end
    end
    
%     Calculating accuracy for VidTIMIT test dataset
    display('Calculating accuracy for VidTIMIT test dataset');
    count = 0.0;
    for index = 1:rows_test
        if(final_label(index,1) == test_class(index,1))
            count = count + 1;
        end
    end
    percentage = count/rows_test * 100;
    disp(sprintf('Accuracy for VidTIMIT test dataset is: %f',percentage));
    
        