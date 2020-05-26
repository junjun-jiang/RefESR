# RefESR
 An effcient ensemble learing super-resolution method (IEEE TNNLS)

Paper: https://ieeexplore.ieee.org/document/8656554 (IEEE Xplore) 
       https://arxiv.org/abs/1905.04696 (arXiv) 

### Ensemble Super-Resolution with A Reference Dataset

In this paper, we present a simple but effective single image SR method based on ensemble learning, which can produce a better performance than that could be obtained from any of the SR methods to be ensembled (or called component super-resolvers). Based on the assumption that better component super-resolver should have larger ensemble weight when performing SR reconstruction, we present a Maximum A Posteriori (MAP) estimation framework for the inference of optimal ensemble weights. Specially, we introduce a reference dataset, which is composed of High-Resolution (HR) and LowResolution (LR) image pairs, to measure the qualities (prior knowledge) of different component super-resolvers. To obtain the optimal ensemble weights, we propose to incorporate the reconstruction constraint, which states that the degenerated HR image should be equal to the LR observation one, as well as the prior knowledge of ensemble weights into the MAP estimation framework. Moreover, the proposed optimization problem can be solved by an analytical solution.

----------
![sketch](/framework.png)
----------


### If you find our work useful in your research or publication, please cite our work:
```
@article{jiang2019ensemble,
title={Ensemble Super-Resolution With a Reference Dataset},
author={Jiang, Junjun and Yu, Yi and Wang, Zheng and Tang, Suhua and Hu, Ruimin and Ma, Jiayi},
journal={IEEE Transactions on Systems, Man, and Cybernetics},
pages={1--15},
year={2019}}    
```
