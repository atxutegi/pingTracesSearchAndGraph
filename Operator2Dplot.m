operators={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3\sSE';'Telenor\sSE';'TIM';'WIND';'voda\sES';'voda\sIT'};
operators2={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3 SE';'Telenor SE';'TIM';'WIND';'voda ES';'voda IT'};
position1=[1 5 9];
position2=[4 8 12];
names={'Ping2Dplot1';'Ping2Dplot2';'Ping2Dplot3'};

for round=1:size(names,1)
    hand=figure('units','normalized','outerposition',[0 0 1 1]);
    for j=position1(1,round):position2(1,round) %size(operators,1)
        subplot(2,2,j-4*(round-1))
        set(0,'defaulttextinterpreter','latex')
        files=dir(strcat('pingOperatorTraces/',operators{j,1},'*'));
        hold all;
        %mpdc = distinguishable_colors(length(files));
        cc=jet(length(files));
        set(0,'defaulttextinterpreter','latex')
        for i=1:size(files,1)
            trace=dlmread(strcat('pingOperatorTraces/',files(i,1).name));
            token = strtok(files(i,1).name, '.');
            token2 = strsplit(token, '-');
            nodeID=token2{1,2};
            plot (trace(:,2)-trace(1,2),trace(:,3),'.','Color',cc (i,:) ,'DisplayName', strcat('Node ',nodeID));     
        end
        xlim ([0 86400])
        xlabel('Time (s)','Interpreter', 'latex','FontSize',16)
        ylabel('RTT (ms)','Interpreter', 'latex','FontSize',16)
        title(operators2{j,1},'Interpreter', 'latex','FontSize',20)
        legend('show')
        legend('Location','eastoutside')
    end
    saveFigure(hand, names{round,1})
    close all
end