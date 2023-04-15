#!/bin/sh

echo running entrypoint script...

cd /tensor2robot/proto
echo running protoc
/protoc/bin/protoc -I=./ --python_out=. t2r.proto

echo running test 1
cd /
python3.7 -m robotics_transformer.tokenizers.action_tokenizer_test

echo running test 2
# cd /robotics_transformer
# bazel test ...
python3.7 -m robotics_transformer.transformer_test