# ECG Analysis on Maternal Uterine Contraction
# Author
- Alfitra Prima Putra (alfitrapp@gmail.com)
- Chan Sook Wei (sookwei97@outlook.com)
- Dehan Ammaralda Handiana (dehanseal@gmail.com)
- Lorenz Yong Jun Jie (yonglorenz@gmail.com)
- MAGD AL SAYED WAHBE (majdwahbe@hotmail.com)
- Tan Lee Hui (tanleehui0418@gmail.com)

# This is project report used for share what we found. Further improvement / feedback is needed

Continuous monitoring of ECG signal is required to examine the physiological and pathological conditions of the heart. During pregnancy, maternal ECG monitoring is significant due to the reason there are numerous physiological changes in particular change in the cardiovascular system. In fact, there is an effect for the maternal uterine contraction on the heart rate that is associated with heart rate deceleration. In this study, a computational tool, MATLAB is used in order  to analyse and observe the differences between the baseline ECG with maternal uterine ECG. Denoising and filtering processes have been done before fast fourier transform in order to analyse the baseline and maternal uterine contraction ECG. From the statistical analysis, t-test results, it shows that all the p values are less than 0.05 which shows that there is a significant difference between baseline ECG and maternal uterine contraction ECG.


# Algorithm Flow

![image](https://user-images.githubusercontent.com/57104367/155844601-4b9f1b4a-9c4b-4ab5-87c4-076f3b1328d8.png)

In this study, ECG signal dataset used is Fetal ECG Synthetic Database [5] retrieved from physionet. Dataset consists of a 5 minutes length with 250Hz sampling frequency and Signal-to-Noise Ratio (SNR) 12dB. These dataset taken from ECG database includes 6 generated using a maternal ECG simulator with normal condition and during uterine contraction.
Each dataset includes main signal data and header data. This data can be separated into 34 leads of ECG. However, only Lead II ECG is required for this study to evaluate the overall comparison between maternal normal condition and uterine contraction.

Non-Local Means (NLM) is an algorithm that is usually to denoise images on the pre-processing part [6]. Unlike other non-local filters that take the mean from a group of  pixels, non-local means take the mean from all pixel targets [7]. This algorithm may create a more clear result rather than a normal non-local filter.
Despite their characteristic to denoise 2-D signals, NLM also can be used for 1-D signals processing. NLM addressed the problem of signal v = u + n where u is ECG signal and n is additive noise. For a given sample s, the estimate uˆ(s) is a weighted sum of values at other points t that are within some “search neighborhood’ N(s)


![image](https://user-images.githubusercontent.com/57104367/155844642-4102ef10-0f9c-4a28-bc53-2cd593c6bbb7.png)


Where,
![image](https://user-images.githubusercontent.com/57104367/155844646-57a99417-182d-4dfe-8e34-b60cd258560c.png)


And,
![image](https://user-images.githubusercontent.com/57104367/155844649-a9d22f5f-b3d3-4484-b200-7725fdd5c56e.png)

Δ represent as local patch samples surrounding s, achieve optimal denoising result by choosing the patch as 20 and neighborhood search width 500 to make sure that the filter is not remove ECG waveform characteristic.



![image](https://user-images.githubusercontent.com/57104367/155844657-97254cd6-1b9a-4931-b187-e2f7d1adc0dd.png)



Input signal from database imported to MATLAB. Figure below shows the input from the dataset sub01_snr12dB_l1_c0_mecg.



![image](https://user-images.githubusercontent.com/57104367/155844661-455fd1ea-bae1-4517-8f59-bef8d74940b1.png)



And denoised using Non-Local Means (NLM)


![image](https://user-images.githubusercontent.com/57104367/155844685-d2d28be4-dba5-4d66-88f2-d65c0d45b6d5.png)



# Result

FFT on Normal Maternal Condition


![image](https://user-images.githubusercontent.com/57104367/155844732-6a98e539-f7db-473a-b901-321723565ae6.png)




FFT on Maternal Uterine Contraction Condition




![image](https://user-images.githubusercontent.com/57104367/155844741-f09075fd-fc0b-40ec-a668-3e76ffe37ea2.png)



T - Test Statistical Result


![image](https://user-images.githubusercontent.com/57104367/155844556-19a7337b-6dcb-4452-b41c-ae02a5a2f019.png)


# Conclusion

In conclusion, the computational analysis, MATLAB can be used as a tool to analyse the maternal uterine ECG. The NLM is used to denoise the ECG signal before it undergoes filtering and fast fourier transform into frequency domain. From the result of the study, it shows that there is a significant difference between baseline ECG and maternal uterine contraction ECG. This indicates that ECG monitoring is able to monitor and observe the differences between maternal uterine condition and normal uterine condition.


# References

[1]  Kaur, N., & Neetu. (2016, January). ECG Signal Denoising With Non Local Means Filter. International Journal of Advanced Research in Computer and Communication Engineering, 5(1).\

[2]  M, S., S, C., & Brid, S. V. (2014). Electrocradiographic Qrs Axis, Q Wave and T-wave Changes in 2nd and 3rd Trimester of Normal Pregnancy. Journal of clinical and diagnostic research : JCDR, 8(9), BC17–BC21. https://doi.org/10.7860/JCDR/2014/10037.4911

[3]  William C. Shiel Jr. (n.d.). Medical Definition of Uterine contraction. Retrieved from https://www.medicinenet.com/uterine_contraction/definition.htm
 
[4]  Lappen, J. R., Chien, E. K., & Mercer, B. M. (2018). 		Contraction-Associated Maternal Heart Rate Decelerations: A 	Pragmatic Marker of Intrapartum Volume Status. Obstetrics and 	gynecology, 132(4), 1011–1017. 				https://doi.org/10.1097/AOG.0000000000002808

[5]  F. Andreotti, J. Behar, S. Zaunseder, J. Oster, and G. D. Clifford, “An 	open-source framework for stress-testing non-invasive foetal ECG 	extraction algorithms,” Physiological Measurement, vol. 37, no. 5, 	pp. 627–648, Apr. 2016, doi: 10.1088/0967-3334/37/5/627.

[6]  B. H. Tracey and E. L. Miller, “Nonlocal Means Denoising of ECG 	Signals,” IEEE Transactions on Biomedical Engineering, vol. 59, no. 	9, pp. 2383–2386, Sep. 2012, doi: 10.1109/tbme.2012.2208964.

[7]  A. Buades, B. Coll, and J.-M. Morel, “A Non-Local Algorithm for 	Image Denoising,” 2005 IEEE Computer Society Conference on 	Computer Vision and Pattern Recognition (CVPR’05), doi: 		10.1109/cvpr.2005.38.
