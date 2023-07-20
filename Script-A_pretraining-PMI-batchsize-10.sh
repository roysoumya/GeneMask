export KMER=6
export TRAIN_FILE= path to pretraining data
export TEST_FILE= path to pretraining validation data
export SOURCE= path to root directory of DNABert codebase
export OUTPUT_PATH=./models/output$KMER-PMImasking-warmup-correction-batch-10

python run_pretrain_pmi.py \
    --output_dir $OUTPUT_PATH \
    --model_type=dna \
    --tokenizer_name=dna$KMER \
    --config_name=$SOURCE/src/transformers/dnabert-config/bert-config-$KMER/config.json \
    --do_train \
    --train_data_file=$TRAIN_FILE \
    --do_eval \
    --eval_data_file=$TEST_FILE \
    --mlm \
    --gradient_accumulation_steps 25 \
    --per_gpu_train_batch_size 10 \
    --per_gpu_eval_batch_size 6 \
    --save_steps 1000 \
    --save_total_limit 20 \
    --max_steps 10000 \
    --evaluate_during_training \
    --logging_steps 500 \
    --line_by_line \
    --learning_rate 8e-4 \
    --block_size 512 \
    --adam_epsilon 1e-6 \
    --weight_decay 0.01 \
    --beta1 0.9 \
    --beta2 0.98 \
    --mlm_probability 0.0176 \
    --warmup_steps 500 \
    --overwrite_output_dir \
    --n_process 24