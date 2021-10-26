terraform-stack-demo
====================

Requerimiento
-------------
* cmake
* aws-cli
* terraform

Help
----
* make
* make help

Comandos
--------
```console
Target           Help                                                      Usage
------           ----                                                      -----
stack.deploy     Ejecutar despliegue del Stack                             make stack.deploy
stack.destroy    Eliminar despliegue del Stack                             make stack.destroy
tf.apply         Aplicar add, change o remove de recursos                  make tf.apply
tf.destroy       Eliminar despliegue de la infraestructur                  make tf.destroy
tf.init          Inicializar terraform                                     make tf.init
tf.plan          Plan add, change o remove de recursos                     make tf.plan
tf.update        Actualizar recursos                                       make tf.update
```

Confirmación
------------
Por defecto no solicita la confirmación al momento de ejecutar el stack, para habilitar la confirmación se debe sobreescribir el valor de la variable de la siguiente forma:
```console
AUTO_APPROVE="" make stack.deploy
```