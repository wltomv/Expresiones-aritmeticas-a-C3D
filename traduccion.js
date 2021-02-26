
var parser = require('./jison/gramatica');

function ejecutar(texto)
{
    try
    {
        let traduccion = parser.parse(texto);
        console.log("Codigo de 3 direcciones");
        console.log(traduccion.C3D);
        console.log("------------------------------------------");
    }catch(err)
    {
        console.log(err);
    }
}


function generarC3D(){
    let entrada;
    
    console.log("escriba una cadena de entrada, para salir escriba exit");
    console.log("-----------------------------------")
    process.stdout.write("entrada: ");
    
    process.stdin.on('data',function(data){
        entrada=data.toString().trim();
        if (entrada=="exit"){
            process.exit();
        }
        else{
            ejecutar(entrada);
            process.stdout.write("entrada: ");
        }
        
    })
   
}
generarC3D();