%% PA1, 2021-09-01, Mutual Coupling Antenna Calibration Estimation
%% PA2, 2021-10-03, Add 3d plot: surf
%% Draft: Hiding the code for Confidential

clear all
close all

%% input: AC parameters
bw_Channel = '20MHz'
ratio_DMC_Nfft = []
Nsamps = 19200
NpdLengthExtend = []
prodName = []
fnum = []
fnum_save_dir = 0

%% output: AC waveform
if 0
    [waveformAC,acConfig] = AntCal_genACSource_g102(bw_Channel, ratio_DMC_Nfft, Nsamps, NpdLengthExtend, prodName, fnum, fnum_save_dir);
else
    load('waveform_AC_20MHz_1C_30p72MHz.mat')
end

%% input: Ant. settings
Nsamps = 8 % based on frequency points
N1 = 5
NAnt = 4

%% output: AC waveform based on freqs and Ants
wf = waveformAC(N1:N1+Nsamps-1,1:NAnt);

%% input: Tx impariment matrix: [Nsamps(Freqs) x NAnt]
TxMag = 10.^([7.1, 4.4, 1.4, 4]/20);
TxDeg = [5, -2, 1, 4];
TxMag = 10.^([1, 1.7, 0.7 -4]/20);
TxDeg = [5, 8, 4 -4];
TxMag = TxMag(1:NAnt).*ones([Nsamps,NAnt]);
TxDeg = TxDeg(1:NAnt).*ones([Nsamps,NAnt]);
Tx = TxMag.*exp(1i*TxDeg/180*pi).*wf;

%% input: Rx impariment matrix: [Nsamps(Freqs) x NAnt]
RxMag = 10.^([1, 1.7, 0.7 -4]/20);
RxDeg = [11, -8, 24 -14];
RxMag = RxMag(1:NAnt).*ones([Nsamps,NAnt]);
RxDeg = RxDeg(1:NAnt).*ones([Nsamps,NAnt]);
Rx = RxMag.*exp(1i*RxDeg/180*pi);

%% input: Antenna S matrix [NAnt(Rx) x NAnt(Tx) x Nsamps(Freqs)]
Smag = [0 1.1 1.3 1.4;...
    1.1 0 1.7 2.4;...
    1 1.2 0 3.4;...
    4.1 4.2 4.3 0];
Sdeg = [0 -3 -1 -1.4;...
    8 0 -1.4 2.4;...
    3 2.4 0 3.4;...
    4.1 4.2 4.3 0];
Smag = Smag(1:NAnt,1:NAnt).*ones([NAnt,NAnt,Nsamps]);
Sdeg = Sdeg(1:NAnt,1:NAnt).*ones([NAnt,NAnt,Nsamps]);
S = Smag.*exp(1i*Sdeg/180*pi);

% input: s matrix reciprocity
flag_reciporcity_S = 0
if flag_reciporcity_S
    for m=1:size(S,2)
        for n=1:size(S,1)
            S_tmp = reshape(S(n,m,1), [], 1);
        end
    end
end

%% output: Y matrix
Y = zeros(size(S));
Rx_tmp = repmat(reshape(Rx.', [NAnt,1,Nsamps]),[1,NAnt]);
Tx_tmp = repmat(reshape(Tx.', [1,NAnt,Nsamps]),[NAnt,1]);
Y = Rx_tmp.*S.*Tx_tmp;

%% step1, setup initial Tx or Rx
TmDegEst = 2*[1 1 1 1];
TmMagEst = 10.^([1 5 1 -1]/20);
RnDegEst = 2*[1 2 3 4];
RnMagEst = 10.^([1 5 1 -1]/20);
TmDegEst_result = repmat(TmDegEst, Nsamps,1);
TmMagdBEst_result = repmat(TmMagEst, Nsamps,1);


%% step1b, initialization
RnEst = zeros(Nsamps,NAnt);%  RnEst matrix: [Nsamps(Freqs) x NAnt]
TmEst = zeros(Nsamps,NAnt);%  TmEst matrix: [Nsamps(Freqs) x NAnt]
TmEst_tmp = zeros(1,NAnt,Nsamps); % TmEst_tmp matrix:[1 x NAnt x Nsamps]
RnEst_tmp = zeros(NAnt,1,Nsamps); % RnEst_tmp matrix:[NAnt x 1 x Nsamps]
TmDegEst_diff = 10
RnDegEst_diff = 10
prioritySolve = 'Rx'
RnDegEst_debug = []

iter = 1
tol = 0.01 % tolerance
while 1
    %% step1, generate Ynm matrix : [Y21;Y31;Y41;...;Y12;Y32;Y42;...;Y13;Y23;Y43;...;Y14;Y24;Y34;...], for LS solve
    if iter==1
        Hide
    end
    
    if strcmpi(prioritySolve,'Tx')
        %% step2a, steup TmEst -> step2b, generate TmSnmEst -> step2c, solve RnEst -> step4, resolve TmEst
        Hide

        
        %% step2b, generate TmSnmEst
        Hide

        %% step2c, solve RnEst
        Hide

        
    elseif strcmpi(prioritySolve,'Rx')
        %% step2a, steup RnEst -> step3, generate RnSnmEst -> step4, solve TmEst -> step5, resolve RnEst
        Hide
    end
    
    %% step3, generate RnSnmEst
        Hide
   
    %% step4, solve TmEst
        Hide
   
    %% step5, resolve Rn
    if strcmpi(prioritySolve,'Rx')
        %% step5a, generate TmSnmEst
        Hide

        %% step5b, resolve RnEst
        Hide

    end
        Hide

    
    %% step6, compare Estimation result with previous Estimation settings
        Hide

    
    %% step7, update phase estimation and iteration again
    if TmDegEst_diff<tol && RnDegEst_diff<tol
        %% check the covergence from original settings
        Hide
      
        %% check the shift of phaseDeg and magdB
        Hide
        
        %% plot
        color = {'r','g','b','c','m','y','k'};
        figure(101)
        plt_Tx = (TmDegEst_result + TxDeg_shift);
        plt_Rx = (RnDegEst_result - RxDeg_shift);
        
        if size(TmDegEst_result,1)>1
            flag_plt_all = 0
            if flag_plt_all
                ii_1 = 1
            else
                ii_1 = size(plt_Tx,3)
            end
            for ii=ii_1:size(plt_Tx,3)
                colorStr = cell2mat( color( mod(ii,numel(color))+1 ) );
                subplot(1,2,1)
                plt_Tx_iter = plt_Tx(:,:,ii);
                pltTx = surf(plt_Tx_iter, 'DisplayName',num2str(ii), 'FaceColor',colorStr ), hold on, legend
                subplot(1,2,2)
                plt_Rx_iter = plt_Rx(:,:,ii);
                pltRx = surf(plt_Rx_iter, 'DisplayName',num2str(ii), 'FaceColor',colorStr ), hold on, legend
            end
            subplot(1,2,1)
            pltTx = surf(TxDeg, 'DisplayName','TxDeg', 'FaceColor', 'w', 'Linewidth',2, 'Linestyle','-.' ), hold on, legend
            title('Tx phase estimation iteration')
            xlabel('Antennas')
            ylabel('Freqs Points')
            zlabel('Phase Estimations')
            subplot(1,2,2)
            pltRx = surf(RxDeg, 'DisplayName','RxDeg', 'FaceColor', 'w', 'Linewidth',2, 'Linestyle','-.' ), hold on, legend
            title('Rx phase estimation iteration')
            xlabel('Antennas')
            ylabel('Freqs')
            zlabel('Phase Estimations')
            
            if 0
                figure('Name','Phase Estimation error')
                subplot(1,2,1)
                Error_TxEstimation = TxDeg-plt_Tx_iter;
                for ii=1:NAnt
                    plot(Error_TxEstimation(:,ii), 'DisplayName', ['Antenna',num2str(ii)], 'Linewidth',2), hold on, legend
                end
                title(['Tx phase estimation', num2str(iter),' iteration Error'])
                xlabel('Freqs Points')
                ylabel('Phase Estimations Error(Deg.)')
                
                subplot(1,2,2)
                Error_RxEstimation = RxDeg-plt_Rx_iter;
                for ii=1:NAnt
                    plot(Error_RxEstimation(:,ii), 'DisplayName', ['Antenna',num2str(ii)], 'Linewidth',2), hold on, legend
                end
                title(['Rx phase estimation', num2str(iter),' iteration Error'])
                xlabel('Freqs Points')
                ylabel('Phase Estimations Error(Deg)')
            end
            
        else
        Hide
     
        end
        break
    else
        TmDegEst = TmDegEst2;
        TmMagEst = TmMagEst2;
        RnDegEst = RnDegEst2;
        RnMagEst = RnMagEst2;
        iter = iter + 1
        TmDegEst_result(:,:,iter) = TmDegEst;
        TmMagdBEst_result(:,:,iter) = TmMagEst;
        RnDegEst_result(:,:,iter) = RnDegEst;
        RnMagdBEst_result(:,:,iter) = RnMagEst;
    end
    
end


