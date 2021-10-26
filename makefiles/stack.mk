.PHONY: stack.deploy \
		stack.destroy

stack.deploy: tf.init tf.apply ## Ejecutar despliegue del Stack: make stack.deploy

stack.destroy: tf.init tf.destroy ## Eliminar despliegue del Stack: make stack.destroy
