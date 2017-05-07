%   for m=1:20
%             for n=1:20
%                 c =power(2,(m-10));
%                 g = power(2,(n-10));
%                 ss = ['-t 2 -c ',num2str(c),' -g ',num2str(g),' -q'];
%                 model = svmtrain(train_label,train_feature,ss);
%                 [predict_label, accuracy, dec_values] = svmpredict(test_label, test_feature, model);
%                 
%                 if accuracy(1,1)>best_accuracy
%                     best_accuracy = accuracy(1,1);
%                     test_attribute_accuracy(cross_num,i) = accuracy(1,1);
%                     predict_all_attribute(:,i) = predict_label;
%                     predict_dec_values(:,i) = dec_values;
%                     Models(i) =  model;
%                 end          
%             end
%         end

%Datastructure of lable
% 1-2: toe cap
% 3-4: body or vamp
% 5- 10: heel
% 11-13: boot

% part 1: Heel { low heel, high heel, pillar heel, cone heel, slender
%heel,thick heel }
% part 2: toe cap { round, toe-open }
% part 3: Boot { low boot, middle boot, high boot }
% part 4: Body or vamp { ornament or brand on body side, ornament or
% shoelace on vamp }

% 270 training, 34 testing

num_p = 4;

