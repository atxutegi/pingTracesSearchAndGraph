function Operator3DPlot_variousDays (days)
% Execute as Operator3DPlot_variousDays ({'2016-10-02';'2016-10-03';'2016-10-04';'2016-10-05';'2016-10-06';'2016-10-07';'2016-10-08';'2016-10-09';'2016-10-10'})
operators={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3\sSE';'Telenor\sSE';'TIM';'WIND';'voda\sES';'voda\sIT'};
operators2={'Orange';'Telia';'YOIGO';'NetCom';'TelenorS';'Telenor';'3 SE';'Telenor SE';'TIM';'WIND';'voda ES';'voda IT'};
%position1=[1 5 9];
%position2=[4 8 12];
position1=[1 2 3 4 5 6 7 8 9 10 11];
position2=[2 3 4 5 6 7 8 9 10 11 12];
%days={'2016-10-02';'2016-10-03';'2016-10-04';'2016-10-05';'2016-10-06';'2016-10-07';'2016-10-08';'2016-10-09';'2016-10-10'};
maxSize=86400*size(days,1);
%names={'Ping3Dplot1_multipleDays';'Ping3Dplot2_multipleDays';'Ping3Dplot3_multipleDays'};
names={'Ping3Dplot_Orange';'Ping3Dplot_Telia';'Ping3Dplot_YOIGO';'Ping3Dplot_NetCom';'Ping3Dplot_TelenorS';'Ping3Dplot_Telenor';'Ping3Dplot_3_SE';'Ping3Dplot_Telenor_SE';'Ping3Dplot_TIM';'Ping3Dplot_WIND';'Ping3Dplot_voda_ES';'Ping3Dplot_voda_IT'};
for round=1:size(names,1)
    hand=figure('units','normalized','outerposition',[0 0 1 1]);
    for j=1:1 %position1(1,round):position2(1,round)
        %subplot(2,2,j-4*(round-1))
        %files=dir(strcat('pingOperatorTraces/',operators{j,1},'*'));
        tableFile=dlmread(strcat('pingTraces/table-', operators{round,1}, '.txt'));
        %hold all;
        %mpdc = distinguishable_colors(length(files));
        cc=jet(size (tableFile(:,1),1));
        set(0,'defaulttextinterpreter','latex')
        %array(maxSize,size (tableFile(:,1),1))=0;
        
        for i=1:size(tableFile(:,1),1)
            traceBase(maxSize,3)=0;
            nodes{i,1}=tableFile(i,1);
            nodeID=tableFile(i,1);
            counter2=1;
            for q=1:size(days,1)
                if (tableFile(i,q+1)==0)
                    traceBase(counter2:counter2+86399,:)=NaN;
                else
                    trace=dlmread(strcat('pingTraces/', days{q},'/',operators{round,1},'-',int2str(nodes{i,1}),'.txt'));
                    traceBase(counter2:counter2+size(trace(:,3))-1,1)=trace(:,1);
                    traceBase(counter2:counter2+size(trace(:,3))-1,3)=trace(:,3);
                    traceBase(counter2:counter2+size(trace(:,3))-1,2)=trace(:,2)-trace(1,2)+counter2;
                end
                counter2=counter2+86400;
            end
                        
            where_zeros = find(traceBase(:,3) == 0);
            traceBase(where_zeros,3) = NaN;
            loca(1:maxSize,1)=i;
            plot3(loca(:,1),traceBase(:,2),traceBase(:,3) ,'Marker', '.','Color',cc (i,:) ,'DisplayName', strcat('Node ',int2str(nodeID)));
            hold all;
            clear loca
            %pause;
        end
        %pause;
        xlim ([0 i+1])
        set(gca,'YTick',[1:86400:maxSize]);
        set (gca,'YTickLabels',days(:));
        ylim ([0 maxSize+100])
        xlabel('Node ID','Interpreter', 'latex','FontSize',16)
        set(gca,'XTick',[1:i])
        set(gca,'xticklabel',{nodes{1:i,1}},'FontSize',6)
        ylabel('Time (s)','Interpreter', 'latex','FontSize',16)
        zlabel('RTT (ms)','Interpreter', 'latex','FontSize',16)
        title(operators2{round,1},'Interpreter', 'latex','FontSize',20)
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
