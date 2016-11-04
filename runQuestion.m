function []= runQuestion()
    % asks to input question number to run
    questionNum = input('Enter the question number to be executed [1: Question(1); 2: Question(2)]');
    if questionNum == 1 
        % for question 1 and 2 run binary classification
        binary_classification();
    elseif questionNum == 2
        % for question 3 run multilabel classification 
        multilabel_classification();
    else 
        disp('Wrong number entered');
    end
end