# Astronomy

Code Setup

1. The code is broken into Modules which can be expanded as other modules start adding up
2. The structure of code is broken into model view and controller paradigm to ensure decoupling is maintained
3. Resources Folders carry common pieces of code such as extensions,images,etc
4. Repository Layers are added to ensure Network class is totally decoupled

Scenarios Not Covered

1. On First Launch if API fails there is no fallback data
2. The image set is of Aspect fit type which may leave space on edges 
3. Image Caches are not maintained so Image load will fail if network is absent
