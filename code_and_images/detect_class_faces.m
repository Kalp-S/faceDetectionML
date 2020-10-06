run('C:\Users\kalps\Documents\vlfeat-0.9.21\toolbox\vl_setup')
load('my_svm.mat')
imageDir = 'class';
imageList = dir(sprintf('%s.jpg',imageDir));
nImages = 1;

bboxes_f = zeros(0,4);
confidences_f = zeros(0,1);
image_names_f = cell(0,1);
    
cellSize = 6;
dim = 36;
scales = [1, 0.95, 0.9, 0.85, 0.8, 0.75, 0.7, 0.65, 0.6, 0.55, 0.5,0.45,0.4,0.35,0.3];
scales_size = size(scales, 2);

for i=1:nImages
    % load and show the image
    im = im2single(imread(sprintf('%s',imageList(i).name)));
    imshow(im);
    hold on;
    
    tempIm = im;
    
    bboxes = zeros(0,4);
    confidences = zeros(0,1);
    image_names = cell(0,1);
    
    % Scaling 
    for j=1:scales_size
        % generate a grid of features across the entire image. you may want to 
        % try generating features more densely (i.e., not in a grid)
        scale = scales(j);
        tempIm = imresize(im,scale);
        feats = vl_hog(tempIm,cellSize);

        % concatenate the features into 12x12 bins, and classify them (as if they
        % represent 36x36-pixel faces)
        [rows,cols,~] = size(feats);    
        confs = zeros(rows,cols);
        for r=1:rows-5
            for c=1:cols-5
                start_X = r;
                start_Y = c;
                end_X = r + cellSize - 1;
                end_Y = c + cellSize - 1;
                feature_vec = feats(start_X:end_X, start_Y: end_Y, :);
                confs(r, c) = feature_vec(:)'*w+b;
            end
        end

        % get the most confident predictions 
        [~,inds] = sort(confs(:),'descend');
        %inds = inds(20); % (use a bigger number for better recall)
        
        recall_num = 32;
        if (size(inds, 1) < recall_num)
            recall_num = size(inds, 1);
        end
        inds = inds(1:recall_num); % (use a bigger number for better recall)   
        
        
        bbox_temp = [];
        for n=1:numel(inds)        
            [row,col] = ind2sub([size(feats,1) size(feats,2)],inds(n));

            bbox = [ col*cellSize/scale ...
                     row*cellSize/scale ...
                    ((col*cellSize+dim)/scale-1) ...
                    ((row*cellSize+dim)/scale-1)];
            conf = confs(row,col);
            if conf < 1.4
                continue
            end
            image_name = {imageList(i).name};
            
            bbox_temp = [bbox_temp; bbox];      
            bboxes = [bboxes; bbox];
            confidences = [confidences; conf];
            image_names = [image_names; image_name];
        end

    end
        
       %low-maximum supression
       % sort detections by decreasing confidence
        [sc,si]=sort(-confidences);
        %image_ids=image_ids(si);
        bboxes = bboxes(si,:);

        % assign detections to ground truth objects
        nd=length(confidences);
        gt_isclaimed = zeros(nd, 1);

        for d=1:nd
            % display progress
            bb = bboxes(d,:);
            ovmax=-inf;
            pick = true;
            for j = 1: nd
                if(gt_isclaimed(j) == 1)
                    bbgt=bboxes(j,:);
                    bi=[max(bb(1),bbgt(1)) ; max(bb(2),bbgt(2)) ; min(bb(3),bbgt(3)) ; min(bb(4),bbgt(4))];
                    iw=bi(3)-bi(1)+1;
                    ih=bi(4)-bi(2)+1;
                    if iw>0 && ih>0       
                        % compute overlap as area of intersection / area of union
                        ua=(bb(3)-bb(1)+1)*(bb(4)-bb(2)+1)+...
                           (bbgt(3)-bbgt(1)+1)*(bbgt(4)-bbgt(2)+1)-...
                           iw*ih;
                        ov=iw*ih/ua;
                        if ov>0
                            pick = false;
                        end
                    end
                end
            end
%             % assign detection as true positive/don't care/false positive
%             if ovmax >= 0.2
%                 if ~gt_isclaimed(jmax)
%                     gt_isclaimed(jmax)=true;
%                 else
%                     gt_isclaimed(jmax)=false;
%                 end
%             end
            gt_isclaimed(d)=pick;
        end
        
       %lets plot our bound boxes
        for j = 1 : nd
            if (gt_isclaimed(j))
                %fprintf('Valid Index: %d\n', j);
                bbox = bboxes(j, :);
                plot_rectangle = [bbox(1), bbox(2); ...
                    bbox(1), bbox(4); ...
                    bbox(3), bbox(4); ...
                    bbox(3), bbox(2); ...
                    bbox(1), bbox(2)];
                plot(plot_rectangle(:,1), plot_rectangle(:,2), 'g-');
            end
        end

        bboxes_f = [bboxes_f; bboxes];
        confidences_f = [confidences_f; confidences];
        image_names_f = [image_names_f; image_names];
    
  %pause; 
    fprintf('got preds for image %d/%d\n', i,nImages);
end