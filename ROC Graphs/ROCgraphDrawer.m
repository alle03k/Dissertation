a = size(y,1);
for i = 1:a
    scatter(x(i,1),y(i,1),80,m{i,1},'MarkerEdgeColor','black','MarkerFaceColor',c{i,1});
    hold on
end
grid on;
axis([0 1 0 1]);
title(' 1 vs 2 & 3 ROC Graph');
xlabel('1 - Specificity');
ylabel('Sensitivity');
legend1 = legend('Knn Average Uncentred','SVM Uncentred','Soft Max Layer NN Uncentred','Pattern Recognition Feed Forward NN Uncentred',...
    'Knn Average Centred','SVM Centred','Soft Max Layer NN Centred','Pattern Recognition Feed Forward NN Centred');
%  legend1 = legend('Knn Average Uncentred','Knn 3-Prioritised Uncentred','SVM Uncentred','Soft Max Layer NN Uncentred','Pattern Recognition Feed Forward NN Uncentred',...
%     'Knn Average Centred','Knn 3-Prioritised Centred','SVM Centred','Soft Max Layer NN Centred','Pattern Recognition Feed Forward NN Centred (Error 17%)');
set(legend1,'Location','southoutside');