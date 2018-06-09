%model = load('imagenet-caffe-alex.mat');
%weights = model.layers{1}.weights{1};
filter = zeros(12,8); 
figure();
for i = 1:size(weights,4)
    subplot(12, 8, i);
    imagesc(abs(rgb2gray(weights(:,:,:,i))))
    set(gca,'xtick',[])
    set(gca,'ytick',[])
end

colormap('gray')
