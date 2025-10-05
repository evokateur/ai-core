# Week 7 Progress

- [x] Day 1
  - watched and learned

- [x] Day 2
  - watched and learned

- [x] Day 3 [Colab](https://colab.research.google.com/drive/1XCfjdYgnJMzsegjKYkPdm7BRla-BIZwa#scrollTo=uuTX-xonNeOK)
  - attempted to run training on T4 with the large dataset but got disconnected before it finished. It probably would have taken too long (see below)

- [x] Day 4
  - Can use data generated in [`week6/lite.ipynb`](../week6/lite.ipynb) to train on a T4 box in a reasonable amount of time.
  - [x] generate lite data
  - Alternately, I can figure out what sort of box I *can* use with Colab Pro @ 9.99/mo..

- [ ] Day 5

## Notes

### Five Important Hyper-parameters for QLoRA

#### 1. Target Modules

- Base model architectures are too big to train, so instead we pick a few layers called the target modules
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

#### 3 Learning Rate

- The amount you shift the weights (relative to the loss?) at each training step
- Typically something like 0.0001 or 0.00001
- Learning Rate Schedulers: you can start with a higher learning rate and then gradually reduce it over time; you want your learning rate to get shorter until you're only making very small adjustments to the weights

#### 4. Gradient Accumulation

- Doing several forward passes, accumulating the gradients[^2] without taking a step, then taking a step[^3] after several forward passes
- Steps less frequently, which means it can run a bit faster
- Conceptual similarity to Batch Size
- (We aren't using this in our example)

#### Optimizer

- Formula or algorithm used to update the weights based on the gradients during Optimization
- Can be expensive, and something to change if there are memory issues
- The most common is Adam or AdamW (Adam with Weight Decay)
  - Adam achieves good convergence by storing the rolling average of the previous gradients; however, it adds an additional memory footprint of the order of the number of model parameters.

[^1]: Do you stop at that point?

[^2]: Gradients are the partial derivatives of the loss function with respect to the model's parameters. They indicate how much each parameter should change to reduce the loss. During training, after a forward pass computes the loss, a backward pass calculates these gradients. Optimizers use the gradients to update the parameters, aiming to minimize the loss and improve model performance \[Copilot\]

[^3]: A "step" refers to the process where the optimizer updates the model's parameters using the computed gradients. After accumulating gradients (possibly over several forward passes), taking a "step" means applying those gradients to adjust the parameters, moving them in a direction that should reduce the loss. This is also called an optimization or parameter update step \[Copilot\]
