# 10-shot

export KMER=6
export MODEL_PATH=./models/output$KMER-PMImasking-warmup-correction-batch-10
export DATA_PATH=./sample_data/ft-fewshot/10/prom300-both
export OUTPUT_PATH=.sample_data/ft-fewshot/10/prom300-both/pmi10000-full-warmup


CUDA_VISIBLE_DEVICES=1 python run_finetune.py \
    --model_type dna \
    --tokenizer_name=dna$KMER \
    --model_name_or_path $MODEL_PATH \
    --task_name dnaprom \
    --do_train \
    --do_eval \
    --data_dir $DATA_PATH \
    --max_seq_length 310 \
    --per_gpu_eval_batch_size=9   \
    --per_gpu_train_batch_size=5   \
    --learning_rate 1e-4 \
    --num_train_epochs 20.0 \
    --output_dir $OUTPUT_PATH \
    --logging_steps 100 \
    --save_steps 4000 \
    --warmup_percent 0.1 \
    --hidden_dropout_prob 0.1 \
    --overwrite_output_dir \
    --weight_decay 0.01 \
    --n_process 8


# 1000-shot
export KMER=6
export MODEL_PATH=./models/output$KMER-PMImasking-warmup-correction-batch-10
export DATA_PATH=./sample_data/ft-fewshot/1000/prom300-both
export OUTPUT_PATH=./sample_data/ft-fewshot/1000/prom300-both/pmi10000-full-warmup

CUDA_VISIBLE_DEVICES=0 python run_finetune.py \
    --model_type dna \
    --tokenizer_name=dna$KMER \
    --model_name_or_path $MODEL_PATH \
    --task_name dnaprom \
    --do_train \
    --do_eval \
    --data_dir $DATA_PATH \
    --max_seq_length 310 \
    --per_gpu_eval_batch_size=9   \
    --per_gpu_train_batch_size=15   \
    --learning_rate 5e-5 \
    --num_train_epochs 5.0 \
    --output_dir $OUTPUT_PATH \
    --logging_steps 100 \
    --save_steps 4000 \
    --warmup_percent 0.1 \
    --hidden_dropout_prob 0.1 \
    --overwrite_output_dir \
    --weight_decay 0.01 \
    --n_process 8