function LoginCtrl($state) {
    var self = this;

    var usuarioIdActual = 1;

    function Usuario(usuario, clave) {
        return { id: usuarioIdActual++, usuario: usuario, clave: clave };
    }

    self.usuarios = [
        new Usuario("juanPerez", "1234")
    ];

    var usuario;
    var clave;
    var resultadoLogin;

    var resultadoLogin = "";

    self.login = function() {
        var usuarioEncontrado = _.find(self.usuarios, { usuario: this.usuario });
        if (usuarioEncontrado) {
            if (usuarioEncontrado.clave === this.clave) {
                $state.go("main.busqueda_pois");
            } else {
                this.clave = "";
                this.resultadoLogin = "La clave ingresada es incorrecta (intente con '1234').";
                $state.go("main.login.incorrecto");
            }
        } else {
            this.usuario = "";
            this.clave = "";
            this.resultadoLogin = "El usuario ingresado no existe (intente con 'juanPerez').";
            $state.go("main.login.incorrecto");
        }
    };

};

angular.module('pois-app')
    .controller('LoginCtrl', LoginCtrl);

LoginCtrl.$inject = ["$state"];