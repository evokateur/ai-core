# Week 7 Progress

- [x] Day 1 Colab

- [x] Day 2 Colab (watched)

- [ ] Day 3 Colab

## Notes

### Five Important Hyper-parameters for QLoRA

#### 1. Target Modules

- Base model architecture too big to train, so instead we pick a few layers called the target modules
- The target modules are frozen; we train a lower dimensional (adapter) matrix alongside each target module and apply it as a Δ

#### 2. R: how many dimensions to use for the lower dimensional adapter matrices

- Common to start with R=8; we are starting with R=32, but you can use 8 without much loss if there are memory issues.

#### 3. Alpha: the scaling factor for the adapter matrices

- Formula for change in weights is Alpha x A x B where A and B are the adapter matrices
- Rule of thumb: set Alpha = R x 2

#### 4. Quantization: reducing precision of the base model weights

- We are training with 4-bit quantization (QLoRA) because that's what will fit in our GPU memory

#### 5. Dropout: regularization technique

- Designed to prevent overfitting, where the model learns the training data too well and fails to generalize to new data
- What dropout does is remove a random subset of neurons, from the transformer layers, during each training step, which discourages the weights from being too precise. Supports concept of general understanding in the neural network.
- Using 10% for this example; should experiment with 5% or 20% to see if we get better results.

### Five Important Hyper-parameters for Training

#### 1. Epochs

- How many times are you going to go through the entire dataset?
- Each epoch shifts the weights a little bit more towards the training data

#### 2. Batch Size

- Often we don't take one data point at a time, but instead take a batch of data points and average the gradients across the batch
- When you do multiple epochs, with each epoch it's typical that you re-sort the data so that the batches are different each epoch
- At the end of each epoch you typically save and test the model. At some point you will see the model start to overfit.[^1] You pick the best epoch and consider that the result of your training.

#### 3

[^1]: Do you stop at that point?
