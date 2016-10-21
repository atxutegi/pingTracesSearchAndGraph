operators={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3\sSE';'Telenor\sSE';'TIM';'WIND';'voda\sES';'voda\sIT'};
operators2={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3 SE';'Telenor SE';'TIM';'WIND';'voda ES';'voda IT'};
position1=[1 5 9];
position2=[4 8 12];
names={'Ping3Dplot1';'Ping3Dplot2';'Ping3Dplot3'};
for round=1:size(names,1)
    hand=figure('units','normalized','outerposition',[0 0 1 1]);
    for j=position1(1,round):position2(1,round) %size(operators,1)
        subplot(2,2,j-4*(round-1))
        files=dir(strcat('pingOperatorTraces/',operators{j,1},'*'));
        %hold all;
        %mpdc = distinguishable_colors(length(files));
        cc=jet(length(files));
        set(0,'defaulttextinterpreter','latex')
        for i=1:size(files,1)
            trace=dlmread(strcat('pingOperatorTraces/',files(i,1).name));
            token = strtok(files(i,1).name, '.');
            token2 = strsplit(token, '-');
            nodeID=token2{1,2};
            traceBase(86400,3)=0;
            traceBase(1:size(trace(:,3)),:)=trace(:,:);
            where_zeros = find(traceBase(:,3) == 0);
            traceBase(where_zeros,3) = NaN;
            loca(1:86400,1)=i;
            nodes{i,1}=nodeID;
            plot3(loca(:,1),traceBase(:,2)-traceBase(1,2),traceBase(:,3) ,'Marker', '.','Color',cc (i,:) ,'DisplayName', strcat('Node ',nodeID));
            hold all;
            clear loca
            %pause;
        end
        %pause;
        xlim ([0 i+1])
        ylim ([0 86400])
        xlabel('Node ID','Interpreter', 'latex','FontSize',16)
        set(gca,'XTick',[1:i])
        set(gca,'xticklabel',{nodes{1:i,1}},'FontSize',6)
        ylabel('Time (s)','Interpreter', 'latex','FontSize',16)
        zlabel('RTT (ms)','Interpreter', 'latex','FontSize',16)
        title(operators2{j,1},'Interpreter', 'latex','FontSize',20)
        h_legend=legend('show')
        if(i<16)
            set(h_legend,'FontSize',9)
        else
            set(h_legend,'FontSize',7)
        end
    %legend('Location','eastoutside')
    end
    saveFigure(hand, names{round,1})
    close all
 end
