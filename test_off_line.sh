#!/bin/bash
for num in 0 1 2 3 4 5 6 7 8 9
do
    python src/main_offline.py  result/kitti_image_$2_result.npy.mvo.npy $1$num>log_result/log_rescale_$1_$2_$num
    echo  'evaluation vo'
    python script/evaluate_vo.py dataset/kitti_gt/$2.txt evaluate_result/kitti_image_$2_result_path.txt$1$num >log_result/log_vo_$1_$2_$num
    python script/change_scale.py evaluate_result/kitti_image_$2_result_path.txt$1$num  dataset/kitti_gt/$2_speed.txt $1$num
    python script/evaluate_vo.py dataset/kitti_gt/$2.txt evaluate_result/kitti_image_$2_result_path_gt.txt$1$num>log_result/log_vo_gt_$1_$2_$num
    cat log_result/log_vo_$1_$2_$num
    cat log_result/log_vo_gt_$1_$2_$num
done
cat log_result/log_vo_$1_$2_? > log_result/log_vo_$1_$2_all
cat log_result/log_vo_gt_$1_$2_? > log_result/log_vo_gt_$1_$2_all
python script/calculate_mean.py log_result/log_vo_$1_$2_all
python script/calculate_mean.py log_result/log_vo_gt_$1_$2_all

