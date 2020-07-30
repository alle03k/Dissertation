%Uncentred
error1 = [1,0];
error2 = [1,0];
error3 = [1,0];
error4 = [1,0];
error5 = [1,0];
error6 = [1,0];
error7 = [1,0];
error8 = [1,0];
error9 = [1,0];
error10 = [1,0];
error11 = [1,0];
error12 = [1,0];
error13 = [1,0];
error14 = [1,0];
error15 = [1,0];
error16 = [1,0];
error17 = [1,0];
error18 = [1,0];
error19 = [1,0];
error20 = [1,0];
error21 = [1,0];
error22 = [1,0];
error23 = [1,0];
error24 = [1,0];
error25 = [1,0];
error26 = [1,0];
error27 = [1,0];
error28 = [1,0];
error29 = [1,0];
error30 = [1,0];
error31 = [1,0];
error32 = [1,0];
error33 = [1,0];
error34 = [1,0];
error35 = [1,0];
error36 = [1,0];

for i = 10:500
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 105, 1, i);
%     if(error < error1(1,1))
%         error1(1,1) = error;
%         error1(1,2) = i;
%         savefig('1v23_Uncentred_CE_105_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 105, 2, i);
%     if(error < error2(1,1))
%         error2(1,1) = error;
%         error2(1,2) = i;
%         savefig('1v23_Uncentred_MSE_105_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 60, 1, i);
%     if(error < error3(1,1))
%         error3(1,1) = error;
%         error3(1,2) = i;
%         savefig('1v23_Uncentred_CE_60_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 60, 2, i);
%     if(error < error4(1,1))
%         error4(1,1) = error;
%         error4(1,2) = i;
%         savefig('1v23_Uncentred_MSE_60_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 15, 1, i);
%     if(error < error5(1,1))
%         error5(1,1) = error;
%         error5(1,2) = i;
%     savefig('1v23_Uncentred_CE_15_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 15, 2, i);
%     if(error < error6(1,1))
%         error6(1,1) = error;
%         error6(1,2) = i;
%         savefig('1v23_Uncentred_MSE_15_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 105, 1, i);
%     if(error < error7(1,1))
%         error7(1,1) = error;
%         error7(1,2) = i;
%         savefig('1v23_Centred_CE_105_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 105, 2, i);
%     if(error < error8(1,1))
%         error8(1,1) = error;
%         error8(1,2) = i;
%         savefig('1v23_Centred_MSE_105_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 60, 1, i);
%     if(error < error9(1,1))
%         error9(1,1) = error;
%         error9(1,2) = i;
%         savefig('1v23_Centred_CE_60_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 60, 2, i);
%     if(error < error10(1,1))
%         error10(1,1) = error;
%         error10(1,2) = i;
%         savefig('1v23_Centred_MSE_60_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 15, 1, i);
%     if(error < error11(1,1))
%         error11(1,1) = error;
%         error11(1,2) = i;
%     savefig('1v23_Centred_CE_15_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 15, 2, i);
%     if(error < error12(1,1))
%         error12(1,1) = error;
%         error12(1,2) = i;
%         savefig('1v23_Centred_MSE_15_Best1.fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 105, 1, [i,i]);
%     if(error < error13(1,1))
%         error13(1,1) = error;
%         error13(1,2) = i;
%         savefig('1v23_Uncentred_CE_105_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 105, 2, [i,i]);
%     if(error < error14(1,1))
%         error14(1,1) = error;
%         error14(1,2) = i;
%         savefig('1v23_Uncentred_MSE_105_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 60, 1, [i,i]);
%     if(error < error15(1,1))
%         error15(1,1) = error;
%         error15(1,2) = i;
%         savefig('1v23_Uncentred_CE_60_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 60, 2, [i,i]);
%     if(error < error16(1,1))
%         error16(1,1) = error;
%         error16(1,2) = i;
%         savefig('1v23_Uncentred_MSE_60_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 15, 1, [i,i]);
%     if(error < error17(1,1))
%         error17(1,1) = error;
%         error17(1,2) = i;
%     savefig('1v23_Uncentred_CE_15_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 15, 2, [i,i]);
%     if(error < error18(1,1))
%         error18(1,1) = error;
%         error18(1,2) = i;
%         savefig('1v23_Uncentred_MSE_15_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 105, 1, [i,i]);
%     if(error < error19(1,1))
%         error19(1,1) = error;
%         error19(1,2) = i;
%         savefig('1v23_Centred_CE_105_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 105, 2, [i,i]);
%     if(error < error20(1,1))
%         error20(1,1) = error;
%         error20(1,2) = i;
%         savefig('1v23_Centred_MSE_105_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 60, 1, [i,i]);
%     if(error < error21(1,1))
%         error21(1,1) = error;
%         error21(1,2) = i;
%         savefig('1v23_Centred_CE_60_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 60, 2, [i,i]);
%     if(error < error22(1,1))
%         error22(1,1) = error;
%         error22(1,2) = i;
%         savefig('1v23_Centred_MSE_60_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 15, 1, [i,i]);
%     if(error < error23(1,1))
%         error23(1,1) = error;
%         error23(1,2) = i;
%     savefig('1v23_Centred_CE_15_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 15, 2, [i,i]);
%     if(error < error24(1,1))
%         error24(1,1) = error;
%         error24(1,2) = i;
%         savefig('1v23_Centred_MSE_15_Best[1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 105, 1, [i,i,i]);
%     if(error < error25(1,1))
%         error25(1,1) = error;
%         error25(1,2) = i;
%         savefig('1v23_Uncentred_CE_105_Best[1,1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 105, 2, [i,i,i]);
%     if(error < error26(1,1))
%         error26(1,1) = error;
%         error26(1,2) = i;
%         savefig('1v23_Uncentred_MSE_105_Best[1,1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 60, 1, [i,i,i]);
%     if(error < error27(1,1))
%         error27(1,1) = error;
%         error27(1,2) = i;
%         savefig('1v23_Uncentred_CE_60_Best[1,1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 60, 2, [i,i,i]);
%     if(error < error28(1,1))
%         error28(1,1) = error;
%         error28(1,2) = i;
%         savefig('1v23_Uncentred_MSE_60_Best[1,1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 15, 1, [i,i,i]);
%     if(error < error29(1,1))
%         error29(1,1) = error;
%         error29(1,2) = i;
%     savefig('1v23_Uncentred_CE_15_Best[1,1,1].fig');
%     end
%     [net,error] = PaternRecogFeedford_Neural_Network(Uncentred_Data_1v23, 15, 2, [i,i,i]);
%     if(error < error30(1,1))
%         error30(1,1) = error;
%         error30(1,2) = i;
%         savefig('1v23_Uncentred_MSE_15_Best[1,1,1].fig');
%     end
    [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 105, 1, [i,i,i]);
    if(error < error31(1,1))
        error31(1,1) = error;
        error31(1,2) = i;
        savefig('1v23_Centred_CE_105_Best[1,1,1].fig');
    end
    [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 105, 2, [i,i,i]);
    if(error < error32(1,1))
        error32(1,1) = error;
        error32(1,2) = i;
        savefig('1v23_Centred_MSE_105_Best[1,1,1].fig');
    end
    [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 60, 1, [i,i,i]);
    if(error < error33(1,1))
        error33(1,1) = error;
        error33(1,2) = i;
        savefig('1v23_Centred_CE_60_Best[1,1,1].fig');
    end
    [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 60, 2, [i,i,i]);
    if(error < error34(1,1))
        error34(1,1) = error;
        error34(1,2) = i;
        savefig('1v23_Centred_MSE_60_Best[1,1,1].fig');
    end
    [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 15, 1, [i,i,i]);
    if(error < error35(1,1))
        error35(1,1) = error;
        error35(1,2) = i;
    savefig('1v23_Centred_CE_15_Best[1,1,1].fig');
    end
    [net,error] = PaternRecogFeedford_Neural_Network(Centred_Data_1v23, 15, 2, [i,i,i]);
    if(error < error36(1,1))
        error36(1,1) = error;
        error36(1,2) = i;
        savefig('1v23_Centred_MSE_15_Best[1,1,1].fig');
    end
end
