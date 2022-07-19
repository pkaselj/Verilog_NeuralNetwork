FPGA Neural Network Accelerator (OCR)
=============

### Authors

- Petar Kaselj
- Marijan Simundic Bendic
 
---

### Description


Digital System Design university course project.

Hardware accelerator that takes 28x28 images (configurable) over UART
and performs low-precision general matrix multiplication i.e. INT8 quantized
neural network feed-forward and returns an array of shape 1x10 (configurable)
that contains numbers [-128, 127] which represent probabilities that an image contains
a digit 0-9 (element at index 0 represents probability that a given image
represents/contains a digit 0 etc.)

---

### Model Training

Model was trained in Python using _TensorFlow_ and _Keras_ libraries.

Because of hardware limitations the model consists of an input layer of 784 neurons and a fully connected layer of 10 neurons with _softmax_ activation.

*NOTE: For the sake of hardware implementation simplicity, the model doesn't use biases* 

The model was then INT8 quantized and weights extracted using _Netron_.

The weights and layer sizes were then compiled/sythetized using _Xilinx ISE_ and flashed onto _Spartan 3E_ board.

---

### Development Notes
- Open _NeuralAccelerator.xise_ file with _Xilinx ISE_
- Ignore _plsradi_jr.xise_ unless _NeuralAccelerator.xise_ doesn't work

---

### Configurability

Number and sizes of layers can be configured, as well as weigths. They are formatted in a way defined in documentation 
and compiled/synthetized with source code and uploaded to _Spartan 3E FPGA_ board.

Images are sent over UART.

---

### Dependencies

-	Xilinx ISE
-	Xilinx Spartan3E FPGA chip

---

### Resources

Documentation:
- [Technical Documentation](Docs/)

Source Code:
- [Python Utilites](https://github.com/MSimundic/Verilog_NN_utilities) developed as part of the same project

External resources:
- [_TensorFlow_ Post-Training Quantization Article](https://www.tensorflow.org/lite/performance/post_training_quantization)
- [_TensorFlow_ Quantization Specification](https://www.tensorflow.org/lite/performance/quantization_spec)
- [Quantization Paper \[Bo Chen\]](https://doi.org/10.48550/arXiv.1712.05877)
- [General matrix multiplication library used by _TFLite_](https://github.com/google/gemmlowp)
