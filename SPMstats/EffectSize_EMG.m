%% Effect Sizes
clear ES
effect = {'MainA', 'MainB'};
label= {'Sex', 'Mass'};
posthoc = {'H6F6','H12F12', 'H6H12', 'F6F12'};
signal = {'DeltA','DeltM','DeltP', 'BB', 'TB', 'Supra', 'Infra', 'SubScap', 'Pect', 'Lat'};

for isignal = 1: length(signal)
    %% Select data for each condition
    Male6 = ANOVA.(signal{isignal}).Y(ANOVA.(signal{isignal}).A == 1 & ANOVA.(signal{isignal}).B == 6,:);
    Male12 = ANOVA.(signal{isignal}).Y(ANOVA.(signal{isignal}).A == 1 & ANOVA.(signal{isignal}).B == 12,:);
    Female6 = ANOVA.(signal{isignal}).Y(ANOVA.(signal{isignal}).A == 2 & ANOVA.(signal{isignal}).B == 6,:);
    Female12 = ANOVA.(signal{isignal}).Y(ANOVA.(signal{isignal}).A == 2 & ANOVA.(signal{isignal}).B == 12,:);
    
    
    %% For each effet
    for ieffect = 1:length(effect)
        % Enter in the structure the name of the studied effect and the
        % variable
        ES.effect((isignal-1)*2+ieffect)=label(ieffect);
        ES.variable((isignal-1)*2+ieffect)=signal(isignal);
        
        % If there are any significant clusters in the studied
        % effect/variable
        if ANOVA.(signal{isignal}).(effect{ieffect}).nClusters > 0
            
            %% Compute mean and variances of datasubsets for each significant cluster
            % find the endpoints of each significant cluster
            endpoints = round(cell2mat(cellfun(@(x)(x.endpoints)',ANOVA.(signal{isignal}).(effect{ieffect}).clusters,'UniformOutput',false)))+1';
            
            for iclus = 1:size(endpoints,2)
                meanMale6kg(iclus) = mean(mean(Male6(:,endpoints(1,iclus): endpoints(2,iclus))));
                meanMale12kg(iclus) = mean(mean(Male12(:,endpoints(1,iclus): endpoints(2,iclus))));
                meanFemale6kg(iclus) = mean(mean(Female6(:,endpoints(1,iclus): endpoints(2,iclus))));
                meanFemale12kg(iclus) = mean(mean(Female12(:,endpoints(1,iclus): endpoints(2,iclus))));
                                
                VarMale6kg(iclus) = var(mean(Male6(:,endpoints(1,iclus): endpoints(2,iclus)),2));
                VarMale12kg(iclus) = var(mean(Male12(:,endpoints(1,iclus): endpoints(2,iclus)),2));
                VarFemale6kg(iclus) = var(mean(Female6(:,endpoints(1,iclus): endpoints(2,iclus)),2));
                VarFemale12kg(iclus) = var(mean(Female12(:,endpoints(1,iclus): endpoints(2,iclus)),2));
            end
            
            %% Summarize mean and variance for each variable with a weighted average of each cluster as a function of its duration
            weight = (endpoints(2,:)-endpoints(1,:))/sum(endpoints(2,:)-endpoints(1,:));
            meanMale6kg = sum(weight.*meanMale6kg);
            meanMale12kg = sum(weight.*meanMale12kg);
            meanFemale6kg = sum(weight.*meanFemale6kg);
            meanFemale12kg = sum(weight.*meanFemale12kg);
                       
            VarMale6kg = sum(weight.*VarMale6kg);
            VarMale12kg = sum(weight.*VarMale12kg);
            VarFemale6kg = sum(weight.*VarFemale6kg);
            VarFemale12kg = sum(weight.*VarFemale12kg);
            
            
            %% Compute pooledSD that will be used for all main effect size calculation
            nmale = length(find(ANOVA.(signal{isignal}).A == 1)) / 2;
            nfemale = length(find(ANOVA.(signal{isignal}).A == 2)) / 2;
            pooledSD = sqrt((VarMale6kg*nmale + VarMale12kg*nmale + VarFemale6kg*nfemale + VarFemale12kg*nfemale)/(2*(nmale+nfemale)));
            
            %% Compute the total duration of each effect size: used to weight symbol size in figures
            ES.duration((isignal-1)*2+ieffect)=sum(endpoints(2,:)-endpoints(1,:));
            
            
            
            %% Determine variance for the given comparison
            if strcmp(effect{ieffect},'MainA')
                %pooledSD = sqrt((VarMale*nmale + VarFemale*nfemale)/(nmale+nfemale));
                
                ES.cohenD((isignal-1)*2+ieffect) = (mean([meanFemale6kg meanFemale12kg])-mean([meanMale6kg meanMale12kg]))/pooledSD;
                
            elseif strcmp(effect{ieffect},'MainB')
                
                ES.cohenD((isignal-1)*2+ieffect) = ((meanFemale12kg*nfemale+meanMale12kg*nmale)-(meanFemale6kg*nfemale+meanMale6kg*nmale))/(pooledSD*(nmale+nfemale));
            end
            
            %% if there is an interaction... ça fout la merde
            if ANOVA.(signal{isignal}).IntAB.nClusters > 0
                % find significant interaction cluster
                INTendpoints = round(cell2mat(cellfun(@(x)(x.endpoints)',ANOVA.(signal{isignal}).IntAB.clusters,'UniformOutput',false)))+1';
                % for each main effect cluster, find the overlapping
                % interaction and note its duration
                for iint= 1:size(INTendpoints,2)
                    for iclus = 1:size(endpoints,2)
                        tohide(iclus,iint) = length(find(ismember(endpoints(1,iclus):endpoints(2,iclus),INTendpoints(1,iint):INTendpoints(2,iint))));
                    end
                end
                % Enter the total duration of overlapping interaction for
                % the studied effect/variable to hide in figure
                ES.tohide((isignal-1)*2+ieffect) = sum(sum(tohide));
                clear tohide
            else
                % if there is no interaction, there is nothing to hide
                ES.tohide((isignal-1)*2+ieffect) = 0;
                
            end
            
            
        else
            % if there is no main effect, there is no effect size, no
            % cluster duration and nothing to hide
            ES.cohenD((isignal-1)*2+ieffect) = 0;
            ES.duration((isignal-1)*2+ieffect) = 0;
            ES.tohide((isignal-1)*2+ieffect) = 0;
            
        end
    end
    
%     %% if there is an interaction... ça fout la merde
%     if ANOVA.(signal{isignal}).IntAB.nClusters > 0
%         for iint = 1: length(POSTHoc.(signal{isignal}))
%             ROI = POSTHoc.(signal{isignal}){iint}.ROI;
%             for iposthoc = 1:length(posthoc)
%                 if POSTHoc.(signal{isignal}){iint}.(posthoc{iposthoc}).nClusters > 0
%                     endpoints = round(cell2mat(cellfun(@(x)(x.endpoints)',POSTHoc.(signal{isignal}){iint}.(posthoc{iposthoc}).clusters,'UniformOutput',false)))+1';
%                     endpoints = endpoints+ROI;
%                     
%                     for iclus = 1:size(endpoints,2)
%                         meanMale6kg(iclus) = mean(mean(Male6(:,endpoints(1,iclus): endpoints(2,iclus))));
%                         meanMale12kg(iclus) = mean(mean(Male12(:,endpoints(1,iclus): endpoints(2,iclus))));
%                         meanFemale6kg(iclus) = mean(mean(Female6(:,endpoints(1,iclus): endpoints(2,iclus))));
%                         meanFemale12kg(iclus) = mean(mean(Female12(:,endpoints(1,iclus): endpoints(2,iclus))));
%                                                 
%                         VarMale6kg(iclus) = var(mean(Male6(:,endpoints(1,iclus): endpoints(2,iclus)),2));
%                         VarMale12kg(iclus) = var(mean(Male12(:,endpoints(1,iclus): endpoints(2,iclus)),2));
%                         VarFemale6kg(iclus) = var(mean(Female6(:,endpoints(1,iclus): endpoints(2,iclus)),2));
%                         VarFemale12kg(iclus) = var(mean(Female12(:,endpoints(1,iclus): endpoints(2,iclus)),2));
%                     end
%            %% Summarize mean and variance for each variable with a weighted average of each cluster as a function of its duration
%             weight = (endpoints(2,:)-endpoints(1,:))/sum(endpoints(2,:)-endpoints(1,:));
%             meanMale6kg = sum(weight.*meanMale6kg);
%             meanMale12kg = sum(weight.*meanMale12kg);
%             meanFemale6kg = sum(weight.*meanFemale6kg);
%             meanFemale12kg = sum(weight.*meanFemale12kg);
%                         
%             VarMale6kg = sum(weight.*VarMale6kg);
%             VarMale12kg = sum(weight.*VarMale12kg);
%             VarFemale6kg = sum(weight.*VarFemale6kg);
%             VarFemale12kg = sum(weight.*VarFemale12kg);
%            
%            clear meanMale6kg meanMale12kg meanFemale6kg meanFemale12kg VarMale6kg VarMale12kg VarFemale6kg VarFemale12kg
%            
%            switch posthoc{iposthoc}
%                case 'H6F6'
%                    pooledSD = sqrt((VarMale6kg*nmale VarFemale6kg*nfemale)/(nmale+nfemale));
% 
%                    ES.cohend6 = (meanFemale6kg - meanMale6kg)/pooledSD;
%          
%                     
%                 end
%                     
                    
                    
                    
                    
                end
                
                
