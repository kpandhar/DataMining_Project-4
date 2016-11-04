function []= multilabel_classification()
    type = input('Question 2 \n Enter 1: Polynomial 2: Gaussian');
    if type==1
        display('Polynomial kernel selected');
    elseif type==2
        display('Gaussian Kernel Selected');
    else
        disp('Enter the correct value');
        return;
    end
%     Getting training and test data from database
    training_data = getfield(load('./Dataset/Scene_Data/X_train.mat'), 'X_train');
    training_class = getfield(load('./Dataset/Scene_Data/y_train.mat'),'y_train');
    test_data = getfield(load('./Dataset/Scene_Data/X_test.mat'),'X_test');
    test_class = getfield(load('./Dataset/Scene_Data/y_test.mat'),'y_test');
    
%     Needed data to train and test
    rows_test = size(test_data,1);
    total_unique_classes=6;
    final_label=[];
    
%     Training the SVMs for Scene_Data traning dataset, using fitcsvm
    display('Training models for Scene_Data traning dataset');
    for class=1:total_unique_classes
%         class_index = eq(training_class(:,class),unique_classes(class));
        if type==1   
            SVMModels{class} = fitcsvm(training_data,training_class(:,class),'KernelFunction','polynomial','PolynomialOrder',2,'KernelScale','auto');
        else
            SVMModels{class} = fitcsvm(training_data,training_class(:,class),'KernelFunction','gaussian','KernelScale','auto','BoxConstraint',1);
        end
%         Testing Scene_Data test dataset, using predict
        disp(sprintf('Testing SVM for binary classification of test dataset for CLASS: %d ',class));
        [label,~,~] = predict(SVMModels{class},test_data);
        
%         Making a final array that stores class label for every observation in test dataset
        
        for k=1:rows_test
            final_label(k,class)= label(k);
        end 
    end
    
%     Calculating accuracy for Scene_Data test dataset
    display('Calculating accuracy for Scene_Data test dataset');
    intersect_val=0.0;
    id_vector=[1,1,1,1,1,1];
    union_val=0.0;
    accuracy=0.0;
    for k=1:rows_test
        intersect_val= dot(test_class(k,:),final_label(k,:));
        union_val= dot(test_class(k,:),id_vector)+dot(final_label(k,:),id_vector)-dot(test_class(k,:),final_label(k,:));
        accuracy = accuracy+intersect_val/union_val;
    end
    disp(sprintf('Percentage accuracy for Scene_Data test dataset is: %f',accuracy/rows_test*100));
    
        