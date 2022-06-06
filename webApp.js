const express = require('express');
const aplicacion = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');

var pool = mysql.createPool({
	connectionLimit: 20,
	host: 'localhost',
	user: 'root',
	password: '123456e',
	database: 'blog_viajes',
});

aplicacion.use(bodyParser.json());
aplicacion.use(bodyParser.urlencoded({ extended: true }));

//Todas Las Publicaciones
// aplicacion.get('/api/v1/publicaciones', function (peticion, respuesta) {
// 	pool.getConnection(function (err, connection) {
// 		const query = `SELECT * FROM publicaciones`;

// 		connection.query(query, function (error, filas, campos) {
// 			respuesta.json({ data: filas });
// 		});
// 		connection.release();
// 	});
// });

//todas las publicaciones con palabra clave y autores validados

aplicacion.get('/api/v1/publicaciones/', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		let query;
		const busqueda = peticion.query.busqueda ? peticion.query.busqueda : '';
		if (busqueda == '') {
			query = `SELECT * FROM publicaciones`;
		} else {
			query = `SELECT * FROM publicaciones WHERE 
            titulo LIKE  '%${busqueda}%' 
            OR resumen LIKE '%${busqueda}%' 
            OR contenido LIKE '%${busqueda}%'`;
		}
		connection.query(query, (error, filas, campos) => {
			if (filas.length > 0) {
				respuesta.json({ data: filas });
			} else {
				respuesta.status(404);
				respuesta.send({ errors: ['No se encontraron coincidencias'] });
			}
		});
	});
});
//Todos los Autores
aplicacion.get('/api/v1/autores', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		const query = `SELECT * FROM autores`;

		connection.query(query, function (error, filas, campos) {
			respuesta.json({ data: filas });
		});
		connection.release();
	});
});

//Todas las Publicaciones Por Id
aplicacion.get('/api/v1/publicaciones/:id', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		const query = `SELECT * FROM publicaciones WHERE id=${connection.escape(
			peticion.params.id
		)}`;

		connection.query(query, function (error, filas, campos) {
			if (filas.length > 0) {
				respuesta.json({ data: filas[0] });
			} else {
				respuesta.status(404);
				respuesta.send({ errors: ['No se encuentra la Publicación'] });
			}
		});
		connection.release();
	});
});

//Todos Los autores Por Id
aplicacion.get('/api/v1/autores/:id', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		const query = `SELECT * FROM autores WHERE id=${connection.escape(
			peticion.params.id
		)}`;

		connection.query(query, function (error, filas, campos) {
			if (filas.length > 0) {
				respuesta.json({ data: filas[0] });
			} else {
				respuesta.status(404);
				respuesta.send({ errors: ['No se encuentra la tarea'] });
			}
		});
		connection.release();
	});
});

//Crear Autores con Post

aplicacion.post('/api/v1/autores', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		const query = `INSERT INTO autores (email, contrasena, pseudonimo) 
        Values (${connection.escape(peticion.body.email)}, 
                ${connection.escape(peticion.body.contrasena)}, 
                ${connection.escape(peticion.body.pseudonimo)})`;

		connection.query(query, function (err, filas, campos) {
			const nuevoId = filas.insertId;

			const queryConsulta = `SELECT * FROM autores WHERE id= ${connection.escape(
				nuevoId
			)}`;

			connection.query(queryConsulta, function (err, filas, campos) {
				respuesta.status(201);
				respuesta.json({ data: filas[0] });
			});
		});
		connection.release();
	});
});

// POST con autores Validos

aplicacion.post('/api/v1/publicaciones/', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		let query;
		const email = peticion.query.email ? peticion.query.email : '';
		const contrasena = peticion.query.contrasena
			? peticion.query.contrasena
			: '';
		if (email == '' || contrasena == '') {
			respuesta.json({ errors: ['Falta el Email ó la Contraseña'] });
		} else {
			query = `SELECT * FROM autores WHERE email = '${email}' AND contrasena = '${contrasena}'`;

			connection.query(query, function (error, filas, campos) {
				if (filas.length > 0) {
					const { id } = filas[0];
					let fecha_hora = new Date();
					const queryInsert = `INSERT INTO publicaciones (titulo, resumen, contenido, fecha_hora, autor_id)
                            VALUES (
                                ${connection.escape(peticion.body.titulo)},
                                ${connection.escape(peticion.body.resumen)},
                                ${connection.escape(peticion.body.contenido)},
                                ${fecha_hora},
                                ${id}

                            )`;
					connection.query(queryInsert, (error, filas, campos) => {
						const queryConsultaUltimo = `SELECT * FROM publicaciones WHERE autor_id = ${id}
                                                    ORDER BY id DESC LIMIT 1`;
						connection.query(queryConsultaUltimo, (error, filas, campos) => {
							respuesta.status(201);
							respuesta.json({ data: filas[0] });
						});
					});
				} else {
					respuesta.json({ errors: ['El email y La Contraseña no coinciden'] });
				}
			});
		}

		connection.release();
	});
});

// Eliminacion de publicacion si pertenece a un autor

aplicacion.delete('/api/v1/publicaciones/:id', function (peticion, respuesta) {
	pool.getConnection(function (err, connection) {
		const email = peticion.query.email ? peticion.query.email : '';
		const contrasena = peticion.query.contrasena
			? peticion.query.contrasena
			: '';
		if (email == '' || contrasena == '') {
			respuesta.json({ errors: ['Falta el Email ó la Contraseña'] });
		} else {
			const consultarUsuario = `SELECT * FROM autores WHERE email = '${email}' AND contrasena = '${contrasena}'`;

			connection.query(consultarUsuario, (error, filas, campos) => {
				const { id } = filas[0];

				const query = `SELECT * FROM publicaciones 
                                WHERE id=${connection.escape(
																	peticion.params.id
																)}
                                AND autor_id= ${id}`;
				connection.query(query, function (error, filas, campos) {
					if (filas.length > 0) {
						const queryDelete = `DELETE FROM publicaciones WHERE id=${peticion.params.id} AND autor_id=${id}`;
						connection.query(queryDelete, function (error, filas, campos) {
							respuesta.status(204);
							respuesta.json();
						});
					} else {
						respuesta.status(404);
						respuesta.send({ errors: ['No encontrado'] });
					}
				});
			});
		}

		connection.release();
	});
});

aplicacion.listen(8080, function () {
	console.log('Servidor iniciado');
});
