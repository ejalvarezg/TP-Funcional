import Test.HUnit
import Solucion

main = runTestTT (TestList [test1, test2, test3, test4, test5, test6, test7, test8, test9, test10])

run1 = runTestTT test1
run2 = runTestTT test2
run3 = runTestTT test3
run4 = runTestTT test4
run5 = runTestTT test5
run6 = runTestTT test6
run7 = runTestTT test7
run8 = runTestTT test8
run9 = runTestTT test9
run10 = runTestTT test10

--Para el ejercicio 1
test1 = test [
    " nombresDeUsuarios vacio" ~: (nombresDeUsuarios redVacio) ~?= [],
    " nombresDeUsuarios red de 1" ~: (nombresDeUsuarios redB) ~?= ["Pedro"],
-- red con mismos usuarios, /= pubs y rels    " nombresDeUsuarios redA1" ~: (nombresDeUsuarios redA1) ~?= ["Juan", "Natalia", "Pedro", "Mariela", "Luis", "Marcos", "Nacho", "Eve", "Erik"],
    " nombresDeUsuarios redA2" ~: (nombresDeUsuarios redA2) ~?= ["Juan", "Natalia", "Pedro", "Mariela", "Luis", "Marcos", "Nacho", "Eve", "Erik"],
    " nombresDeUsuarios redA4" ~: (nombresDeUsuarios redA4) ~?= ["Juan", "Pedro", "Natalia"],
    " nombresDeUsuarios redA5" ~: (nombresDeUsuarios redA5) ~?= ["Juan", "Pedro", "Mariela", "Natalia"]
    ]


--Para el ejercicio 2
test2 = test [
    " amigosDe: red con 1 solo usuario" ~: (amigosDe redB usuario3) ~?= [],
    " amigosDe: un amigo en red de varios usuarios" ~: (amigosDe redA1 usuario7) ~?= [(6, "Marcos")],
    " amigosDe: varios amigos en red de varios usuarios" ~: (amigosDe redA1 usuario1) ~?= [(2, "Natalia"), (4, "Mariela")],
    " amigosDe: sin amigos en red de varios usuarios" ~: (amigosDe redA1 usuario5) ~?= []
    ]


--Para el ejercicio 3
test3 = test [
    " cantidadDeAmigos: red con 1 sólo usuario" ~: (cantidadDeAmigos redB usuario3) ~?= 0,
    " cantidadDeAmigos: un amigo en red de varios usuarios" ~: (cantidadDeAmigos redA1 usuario7) ~?= 1,
    " cantidadDeAmigos: varios amigos en red de varios usuarios" ~: (cantidadDeAmigos redA1 usuario1) ~?= 2,
    " cantidadDeAmigos: sin amigos en red de varios usuarios" ~: (cantidadDeAmigos redA1 usuario5) ~?= 0
    ]


--Para el ejercicio 4
test4 = test [
    -- la función está diseñada para que si al menos dos usuarios tienen igual cantidad de amigos, me devuelva el último usuario de ellos (en el orden que aparecen)
    " usuarioConMasAmigos: caso red con un sólo usuario" ~: (usuarioConMasAmigos redB) ~?= usuario3,
    " usuarioConMasAmigos: caso red con varios usuarios y un solo usuario con mas amigos" ~: (usuarioConMasAmigos redC) ~?= usuario1,
    -- como nadie tiene amigos en la redA3, este caso de test, devuelve el último usuario.
    " usuarioConMasAmigos: caso red sin relaciones" ~: (usuarioConMasAmigos redA3) ~?= usuario9,
    " usuarioConMasAmigos: caso con dos usuarios que tienen igual cantidad de amigos" ~: (usuarioConMasAmigos redD) ~?= usuario2
    -- como hay tres usuarios que tienen la misma cantidad de amigos, devuelve el último usuario.
    ]


--Para el ejercicio 5
test5 = test [
    " estaRobertoCarlos: caso red sin usuarios" ~: (estaRobertoCarlos redVacio) ~?= False,
    " estaRobertoCarlos: caso red sin relaciones" ~: (estaRobertoCarlos redA3) ~?= False, 
    " estaRobertoCarlos: caso red con un solo usuario" ~: (estaRobertoCarlos redB) ~?= False,
    " estaRobertoCarlos: caso red con varios usuarios, que tienen menos de 10 amigos o igual a 10" ~: (estaRobertoCarlos redA1) ~?= False,
    " estaRobertoCarlos: caso en el cual hay un sólo usuario con más de 10 amigos" ~: (estaRobertoCarlos redC) ~?= True,
    " estaRobertoCarlos: caso en el cual hay más de un usuario con más de 10 amigos" ~: (estaRobertoCarlos redD) ~?= True
    ]


--Para el ejercicio 6
test6 = test [
    " publicacionesDe: caso un solo usuario en la red, sin publicaciones" ~: (publicacionesDe redH4 usuario3) ~?= [],
    " publicacionesDe: caso un solo usuario en la red, con una publicacion" ~: (publicacionesDe redH5 usuario3) ~?= [publicacion3_1],
    " publicacionesDe: caso un solo usuario en la red, con mas de una publicacion" ~: (publicacionesDe redB usuario3) ~?= postsB,
    " publicacionesDe: caso mas de un usuario en la red, sin publicaciones en la red" ~: (publicacionesDe redH6 usuario3) ~?= [],
    " publicacionesDe: caso mas de un usuario en la red, una publicacion en la red, sin publicaciones el usuario" ~: (publicacionesDe redH7 usuario3) ~?= [],
    " publicacionesDe: caso mas de un usuario en la red, mas de una publicacion en la red, sin publicaciones el usuario" ~: (publicacionesDe redE usuario3) ~?= [],
    " publicacionesDe: caso mas de un usuario en la red, una sola publicacion en la red, es la del usuario" ~: (publicacionesDe redH9 usuario1) ~?= [publicacion1_1],
    " publicacionesDe: caso mas de un usuario en la red, con varias publicacion en la red, una sola es la del usuario" ~: (publicacionesDe redH10 usuario1) ~?= [publicacion1_1],
    " publicacionesDe: caso mas de un usuario en la red, con varias publicacion en la red, mas de una es del usuario" ~: (publicacionesDe redA1 usuario1) ~?= [publicacion1_1, publicacion1_2, publicacion1_3, publicacion1_4, publicacion1_5]
    ]


--Para el ejercicio 7
test7 = test [
    " publicacionesQueLeGustanA: caso un solo usuario en la red, sin publicaciones" ~: (publicacionesQueLeGustanA redH4 usuario3) ~?= [],
    " publicacionesQueLeGustanA: caso un solo usuario en la red, con una sola publicacion, sin likes" ~: (publicacionesQueLeGustanA redH5 usuario3) ~?= [],
    " publicacionesQueLeGustanA: caso un solo usuario en la red, con una sola publicacion, se likea a si mismo" ~: (publicacionesQueLeGustanA redH11 usuario9) ~?= [publicacion9_2],
    " publicacionesQueLeGustanA: caso un solo usuario en la red, con mas de una publicacion, sin likes" ~: (publicacionesQueLeGustanA redB usuario3) ~?= [],
    " publicacionesQueLeGustanA: 1 usuario en la red, > 1 publicacion en la red, > 1 like del usuario, 1 like por publicacion" ~: (publicacionesQueLeGustanA red_ej7_caso5 usuario3) ~?= publicaciones_ej7_caso5,
    " publicacionesQueLeGustanA: > 1 usuario en la red, 0 publicaciones, 0 likes del usuario, 0 likes por publicacion" ~: (publicacionesQueLeGustanA red_ej7_caso6 usuario3) ~?= [],
    " publicacionesQueLeGustanA: > 1 usuario en la red, 1 publicacion, 0 likes del usuario, 0 likes por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso7 usuario3) ~?= [],
    " publicacionesQueLeGustanA: > 1 usuario en la red, 1 publicacion, 0 likes del usuario, > 1 like por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso8 usuario3) ~?= [],
    " publicacionesQueLeGustanA: > 1 usuario en la red, 1 publicacion, 1 like del usuario, 1 like por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso9 usuario3) ~?= [publicacion_ej7_caso9],
    " publicacionesQueLeGustanA: > 1 usuario en la red, 1 publicacion, 1 like del usuario, > 1 like por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso10 usuario3) ~?= [publicacion_ej7_caso10],
    " publicacionesQueLeGustanA: > 1 usuario en la red, > 1 publicacion, 0 likes del usuario, 0 likes por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso11 usuario3) ~?= [],
    " publicacionesQueLeGustanA: > 1 usuario en la red, > 1 publicacion, 0 likes del usuario, > 1 like por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso12 usuario3) ~?= [],
    " publicacionesQueLeGustanA: > 1 usuario en la red, > 1 publicacion, > 1 like del usuario, 1 like por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso13 usuario3) ~?= publicaciones_ej7_caso13,
    " publicacionesQueLeGustanA: > 1 usuario en la red, > 1 publicacion, > 1 like del usuario, > 1 like por publicacion" ~: (publicacionesQueLeGustanA red_test7_caso14 usuario3) ~?= publicaciones_ej7_caso14
    ]


--Para el ejercicio 8
test8 = test [
    " lesGustanLasMismasPublicaciones: red de 2 usuarios, True" ~: (lesGustanLasMismasPublicaciones redB usuario3 usuario3) ~?= True,
    " lesGustanLasMismasPublicaciones: red de 2 usuarios, True" ~: (lesGustanLasMismasPublicaciones redF1 usuario7 usuario8) ~?= True,
    " lesGustanLasMismasPublicaciones: red de 2 usuarios, a uno no le gusta su propia pub" ~: (lesGustanLasMismasPublicaciones redF2 usuario7 usuario8) ~?= False,
    " lesGustanLasMismasPublicaciones: red de 2 usuarios, una publicación sin likes" ~: (lesGustanLasMismasPublicaciones redF3 usuario7 usuario8) ~?= False,
    " lesGustanLasMismasPublicaciones: red de 2 usuarios, ninguna publicación tiene like" ~: (lesGustanLasMismasPublicaciones redF4 usuario7 usuario8) ~?= True,
    " lesGustanLasMismasPublicaciones: red de 2 usuarios, compara al mismo usuario" ~: (lesGustanLasMismasPublicaciones redF2 usuario8 usuario8) ~?= True,
    " lesGustanLasMismasPublicaciones: red de más de 2 usuarios, True" ~: (lesGustanLasMismasPublicaciones redFA usuario7 usuario8) ~?= True,
    " lesGustanLasMismasPublicaciones: red de más de 2 usuarios, no les gustan las mismas" ~: (lesGustanLasMismasPublicaciones redFA usuario5 usuario8) ~?= False,
    " lesGustanLasMismasPublicaciones: red de más de 2 usuarios, difieren por una publicación" ~: (lesGustanLasMismasPublicaciones redFA usuario5 usuario6) ~?= False,
    " lesGustanLasMismasPublicaciones: red de más de 2 usuarios, ninguna publicación tiene like" ~: (lesGustanLasMismasPublicaciones redFA usuario10 usuario11) ~?= True,
    " lesGustanLasMismasPublicaciones: red de más de 2 usuarios, compara al mismo usuario" ~: (lesGustanLasMismasPublicaciones redFA usuario8 usuario8) ~?= True
    ]

--Para el ejercicio 9
test9 = test [
    " tieneUnSeguidorFiel: caso en que el la red tiene solo un usuario" ~: (tieneUnSeguidorFiel redB usuario3) ~?= False,
    " tieneUnSeguidorFiel: caso en que el la red tiene solo un usuario que se da like" ~: (tieneUnSeguidorFiel redB2 usuario3) ~?= False,
    " tieneUnSeguidorFiel: caso una publicacion, un solo seguidor fiel y son amigos" ~: (tieneUnSeguidorFiel redH3 usuario3) ~?= True,
    " tieneUnSeguidorFiel: caso una publicacion, y mas de un seguidor fiel" ~: (tieneUnSeguidorFiel redH2 usuario1) ~?= True,
    " tieneUnSeguidorFiel: caso una publicacion sola, con seguidor fiel que no es amigo" ~: (tieneUnSeguidorFiel redA1 usuario5) ~?= True,
    " tieneUnSeguidorFiel: caso mas de una publicacion, sin seguidor fiel" ~: (tieneUnSeguidorFiel redA1 usuario1) ~?= False,
    " tieneUnSeguidorFiel: caso mas de una publicacion, con dos seguidores fieles" ~: (tieneUnSeguidorFiel redA1 usuario2) ~?= True,
    " tieneUnSeguidorFiel: caso mas de una publicacion, un solo seguidor fiel y son amigos" ~: (tieneUnSeguidorFiel redH usuario2) ~?= True,
    " tieneUnSeguidorFiel: caso mas de una publicacion, un solo seguidor fiel y no son amigos" ~: (tieneUnSeguidorFiel redH1 usuario2) ~?= True,
    " tieneUnSeguidorFiel: caso en que el usuario da like a sí mismo" ~: (tieneUnSeguidorFiel redH12 usuario7) ~?= False,
    " tieneUnSeguidorFiel: caso en que el usuario no tiene publicaciones" ~: (tieneUnSeguidorFiel redH13 usuario7) ~?= False
    ]

--Para el ejercicio 10
test10 = test [
    " existeSecuenciaDeAmigos: red de +2 usuarios. Ninguno de los dos tiene amigos" ~: (existeSecuenciaDeAmigos redTodos1 usuario5 usuario6) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Nadie en la red tiene amigos" ~: (existeSecuenciaDeAmigos redTodos0 usuario5 usuario6) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Cada uno tiene un amigo, no hay sec" ~: (existeSecuenciaDeAmigos redTodos1 usuario1 usuario2) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U1 tiene un amigo, u2 ninguno" ~: (existeSecuenciaDeAmigos redTodos1 usuario1 usuario12) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U2 tiene un amigo, u1 ninguno" ~: (existeSecuenciaDeAmigos redTodos1 usuario12 usuario1) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U1 tiene más de un amigo, u2 ninguno" ~: (existeSecuenciaDeAmigos redTodos2 usuario1 usuario12) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U2 tiene más de un amigo, u1 ninguno" ~: (existeSecuenciaDeAmigos redTodos2 usuario12 usuario1) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U1 tiene más de un amigo, u2 tiene un amigo, no hay sec" ~: (existeSecuenciaDeAmigos redTodos2 usuario1 usuario5) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U2 tiene más de un amigo, u1 tiene un amigo, no hay sec" ~: (existeSecuenciaDeAmigos redTodos2 usuario5 usuario1) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Tienen varios amigos, no hay sec" ~: (existeSecuenciaDeAmigos redTodos3 usuario1 usuario12) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Son amigos directos y no tienen más amigos" ~: (existeSecuenciaDeAmigos redTodos1 usuario1 usuario3) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Son amigos directos y sí tienen más amigos" ~: (existeSecuenciaDeAmigos redTodos4 usuario1 usuario12) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. No son amigos directos, pero tienen un amigo en común. Solo tienen un amigo" ~: (existeSecuenciaDeAmigos redTodos2 usuario3 usuario4) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. No son amigos directos, pero tienen un amigo en común. Tienen varios amigos" ~: (existeSecuenciaDeAmigos redTodos5 usuario1 usuario12) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U1 tiene más de un amigo, u2 tiene un amigo, sí hay sec" ~: (existeSecuenciaDeAmigos redTodos5 usuario1 usuario11) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. U2 tiene más de un amigo, u1 tiene un amigo, sí hay sec" ~: (existeSecuenciaDeAmigos redTodos5 usuario11 usuario1) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Tienen varios amigos, sí hay sec y no es directa" ~: (existeSecuenciaDeAmigos redTodos6 usuario1 usuario12) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Tienen varios amigos, sí hay sec y son varias" ~: (existeSecuenciaDeAmigos redTodos7 usuario1 usuario12) ~?= True,
    " existeSecuenciaDeAmigos: red de 2 usuarios que no son amigos" ~: (existeSecuenciaDeAmigos redG2a usuario1 usuario2) ~?= False,
    " existeSecuenciaDeAmigos: red de 2 usuarios que sí son amigos" ~: (existeSecuenciaDeAmigos redG2b usuario1 usuario2) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Compara al mismo usuario. No tiene amigos" ~: (existeSecuenciaDeAmigos redTodos1 usuario5 usuario5) ~?= False,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Compara al mismo usuario. Tiene un amigo" ~: (existeSecuenciaDeAmigos redTodos1 usuario1 usuario1) ~?= True,
    " existeSecuenciaDeAmigos: red de +2 usuarios. Compara al mismo usuario. Tiene más de un amigo" ~: (existeSecuenciaDeAmigos redTodos4 usuario1 usuario1) ~?= True
    ]

expectAny actual expected = elem actual expected ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)


-- USUARIOS
usuario1 = (1, "Juan")
usuario2 = (2, "Natalia")
usuario3 = (3, "Pedro")
usuario4 = (4, "Mariela")
usuario5 = (5, "Luis")
usuario6 = (6, "Marcos")
usuario7 = (7, "Nacho")
usuario8 = (8, "Eve")
usuario9 = (9, "Erik")
usuario10 = (10, "Ian")
usuario11 = (11, "Paz")
usuario12 = (12, "Pepe")
usuario13 = (13, "Natalia")
usuario14 = (14, "Natalia")

-- RELACIONES
relacion1_2 = (usuario1, usuario2)
relacion1_3 = (usuario1, usuario3)
relacion1_4 = (usuario4, usuario1)
relacion1_5 = (usuario1, usuario5)
relacion1_6 = (usuario1, usuario6)
relacion1_7 = (usuario1, usuario7)
relacion1_8 = (usuario1, usuario8)
relacion1_9 = (usuario1, usuario9)
relacion1_10 = (usuario1, usuario10)
relacion1_11 = (usuario1, usuario11)
relacion1_12 = (usuario1, usuario12)

relacion2_3 = (usuario2, usuario3)
relacion2_4 = (usuario4, usuario2)
relacion2_5 = (usuario2, usuario5)
relacion2_6 = (usuario2, usuario6)
relacion2_7 = (usuario2, usuario7)
relacion2_8 = (usuario2, usuario8)
relacion2_9 = (usuario2, usuario9)
relacion2_10 = (usuario2, usuario10)
relacion2_11 = (usuario2, usuario11)
relacion2_12 = (usuario2, usuario12)

relacion3_4 = (usuario4, usuario3)
relacion3_5 = (usuario3, usuario5)
relacion3_6 = (usuario3, usuario6)
relacion3_7 = (usuario3, usuario7)
relacion3_8 = (usuario3, usuario8)
relacion3_9 = (usuario3, usuario9)
relacion3_10 = (usuario3, usuario10)
relacion3_11 = (usuario3, usuario11)
relacion3_12 = (usuario3, usuario12)

relacion4_5 = (usuario4, usuario5)
relacion4_6 = (usuario4, usuario6)
relacion4_7 = (usuario4, usuario7)
relacion4_8 = (usuario4, usuario8)
relacion4_9 = (usuario4, usuario9)
relacion4_10 = (usuario4, usuario10)
relacion4_11 = (usuario4, usuario11)
relacion4_12 = (usuario4, usuario12)

relacion5_6 = (usuario5, usuario6)
relacion5_7 = (usuario5, usuario7)
relacion5_8 = (usuario5, usuario8)
relacion5_9 = (usuario5, usuario9)
relacion5_10 = (usuario5, usuario10)
relacion5_11 = (usuario5, usuario11)
relacion5_12 = (usuario5, usuario12)

relacion6_7 = (usuario6, usuario7)
relacion6_8 = (usuario6, usuario8)
relacion6_9 = (usuario6, usuario9)
relacion6_10 = (usuario6, usuario10)
relacion6_11 = (usuario6, usuario11)
relacion6_12 = (usuario6, usuario12)

relacion7_8 = (usuario7, usuario8)
relacion7_9 = (usuario7, usuario9)
relacion7_10 = (usuario7, usuario10)
relacion7_11 = (usuario7, usuario11)
relacion7_12 = (usuario7, usuario12)

relacion8_9 = (usuario8, usuario9)
relacion8_10 = (usuario8, usuario10)
relacion8_11 = (usuario8, usuario11)
relacion8_12 = (usuario8, usuario12)

relacion9_10 = (usuario9, usuario10)
relacion9_11 = (usuario9, usuario11)
relacion9_12 = (usuario9, usuario12)

relacion10_11 = (usuario10, usuario11)
relacion10_12 = (usuario10, usuario12)

relacion11_12 = (usuario11, usuario12)

-- PUBLICACIONES
publicacion1_1 = (usuario1, "Este es mi primer post", [usuario2, usuario4, usuario5])
publicacion1_2 = (usuario1, "Este es mi segundo post", [usuario4, usuario5])
publicacion1_3 = (usuario1, "Este es mi tercer post", [usuario2, usuario5, usuario4])
publicacion1_4 = (usuario1, "Este es mi cuarto post", [])
publicacion1_5 = (usuario1, "Este es como mi quinto post", [usuario5, usuario4])

publicacion2_1 = (usuario2, "Hello World", [usuario4, usuario5])
publicacion2_2 = (usuario2, "Good Bye World", [usuario1, usuario4, usuario5])
publicacion2_3 = (usuario2, "Aguante Boquita", [usuario1, usuario4])

publicacion3_1 = (usuario3, "Lorem Ipsum", [])
publicacion3_2 = (usuario3, "dolor sit amet", [usuario2])
publicacion3_3 = (usuario3, "consectetur adipiscing elit", [usuario2, usuario5, usuario4])
publicacion3_4 = (usuario3, "Lorem Ipsum 2", [])
publicacion3_5 = (usuario3, "Lorem Ipsum 3", [usuario3])

publicacion4_1 = (usuario4, "I am Alice. Not", [usuario1, usuario2])
publicacion4_2 = (usuario4, "I am Bob", [])
publicacion4_3 = (usuario4, "Just kidding, i am Mariela", [usuario1, usuario3])

publicacion5_1 = (usuario5, "Publicacion única", [usuario1, usuario3, usuario7, usuario8])

publicacion6_1 = (usuario6, "Casi como publicacion9_1", [usuario7, usuario8])

publicacion7_1 = (usuario7, "Me gusta mi propia publicación", [usuario7, usuario8, usuario5, usuario6])
publicacion7_2 = (usuario7, "Esta publicación no me gusta", [usuario8])
publicacion7_3 = (usuario7, "A nadie le gusta", [])
publicacion7_4 = (usuario7, "NN", [usuario7])

usersH12 = [usuario7, usuario8]
redH12 = (usersH12, [], [publicacion7_4]) --Se da like a sí mismo y nadie más le da like: False
redH13 = (usersH12, [], []) --Usuario no tiene publicaciones

publicacion8_1 = (usuario8, "A mí también me gusta mi publicación", [usuario8, usuario7, usuario5, usuario6])
publicacion8_2 = (usuario8, "Solo a mi amigo le gusta esta publicación", [usuario7])
publicacion8_3 = (usuario8, "Nobody likes me", [])

publicacion9_1 = (usuario9, "Casi como publicacion6_1", [usuario7, usuario8, usuario6])
publicacion9_2 = (usuario9, "Estoy solito", [usuario9])

--REDES

-- red sin usuarios
usuariosVacio = []
relacionesVacio = []
postsVacio = []
redVacio = (usuariosVacio, relacionesVacio, postsVacio)

usersA = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9]
usersA4 = [usuario1, usuario2, usuario3, usuario13]
usersA5 = [usuario1, usuario2, usuario3, usuario13, usuario4, usuario14]
relsA1 = [relacion1_2, relacion1_4, relacion2_3, relacion2_4, relacion3_4, relacion3_6, relacion6_7]
relsA2 = [relacion1_2, relacion1_4, relacion3_8, relacion3_9, relacion4_6, relacion6_7]
postsA = [publicacion1_1, publicacion1_2, publicacion1_3, publicacion1_4, publicacion1_5, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion3_3, publicacion4_1, publicacion4_2, publicacion4_3, publicacion5_1]
redA1 = (usersA, relsA1, postsA)
redA2 = (usersA, relsA2, postsA)
redA3 = (usersA, [], postsA)
redA4 = (usersA4, [], [])
redA5 = (usersA5, [], [])

usersB = [usuario3]
postsB = [publicacion3_1, publicacion3_4]
postsB2 = [publicacion3_5]
-- red con solo un usuario
redB = (usersB, [], postsB)
redB2 = (usersB, [], postsB2)

userC = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11, usuario12]
relsC = [relacion1_2, relacion1_3, relacion1_4, relacion1_5, relacion1_6, relacion1_7, relacion1_8, relacion1_9, relacion1_10, relacion1_11, relacion1_12]
redC = (userC, relsC, postsA)

relsD = [relacion1_2, relacion1_3, relacion1_4, relacion1_5, relacion1_6, relacion1_7, relacion1_8, relacion1_9, relacion1_10, relacion1_11, relacion1_12, relacion2_3, relacion2_4, relacion2_5, relacion2_6, relacion2_7, relacion2_8, relacion2_9, relacion2_10, relacion2_11, relacion2_12]
redD = (userC, relsD, postsA)

postsE = [publicacion1_1, publicacion2_1]
redE = (usersA, relsA1, postsE)


-- redes para el ejercicio 7

usuarios_ej7 = [usuario1, usuario2, usuario3, usuario4]
relaciones_ej7 = [relacion1_2, relacion1_3, relacion2_3, relacion3_4, relacion2_4]

publicacion_ej7_caso5_1 = (usuario3, "Vamo ñuls", [usuario3])
publicacion_ej7_caso5_2 = (usuario3, "me gusta el vino y la joda", [usuario3])
publicacion_ej7_caso5_3 = (usuario3, "Vamo ñuls", [usuario3])
publicaciones_ej7_caso5 = [publicacion_ej7_caso5_1, publicacion_ej7_caso5_2, publicacion_ej7_caso5_3]
red_ej7_caso5 = ([usuario3], [], publicaciones_ej7_caso5)

red_ej7_caso6 = (usuarios_ej7, relaciones_ej7, [])

publicacion_ej7_caso7 = (usuario1, "Vamo ñuls", [])
red_test7_caso7 = (usuarios_ej7, relaciones_ej7, [publicacion_ej7_caso7])

publicacion_ej7_caso8 = (usuario1, "Vamo ñuls", [usuario2, usuario4])
red_test7_caso8 = (usuarios_ej7, relaciones_ej7, [publicacion_ej7_caso8])

publicacion_ej7_caso9 = (usuario1, "Vamo ñuls", [usuario3])
red_test7_caso9 = (usuarios_ej7, relaciones_ej7, [publicacion_ej7_caso9])

publicacion_ej7_caso10 = (usuario1, "Vamo ñuls", [usuario1, usuario2, usuario3])
red_test7_caso10 = (usuarios_ej7, relaciones_ej7, [publicacion_ej7_caso10])

publicacion_ej7_caso11_1 = (usuario1, "Vamo ñuls", [])
publicacion_ej7_caso11_2 = (usuario2, "anda a la cancha bobo", [])
publicaciones_ej7_caso11 = [publicacion_ej7_caso11_1, publicacion_ej7_caso11_2]

red_test7_caso11 = (usuarios_ej7, relaciones_ej7, publicaciones_ej7_caso11)

publicacion_ej7_caso12_1 = (usuario1, "Vamo ñuls", [usuario2, usuario4])
publicacion_ej7_caso12_2 = (usuario2, "anda a la cancha bobo", [usuario2, usuario4])
publicaciones_ej7_caso12 = [publicacion_ej7_caso12_1, publicacion_ej7_caso12_2]

red_test7_caso12 = (usuarios_ej7, relaciones_ej7, publicaciones_ej7_caso12)

publicacion_ej7_caso13_1 = (usuario1, "Vamo ñuls", [usuario3])
publicacion_ej7_caso13_2 = (usuario2, "anda a la cancha bobo", [usuario3])
publicaciones_ej7_caso13 = [publicacion_ej7_caso13_1, publicacion_ej7_caso13_2]

red_test7_caso13 = (usuarios_ej7, relaciones_ej7, publicaciones_ej7_caso13)

publicacion_ej7_caso14_1 = (usuario1, "Vamo ñuls", [usuario3, usuario1])
publicacion_ej7_caso14_2 = (usuario2, "anda a la cancha bobo", [usuario3, usuario2])
publicaciones_ej7_caso14 = [publicacion_ej7_caso14_1, publicacion_ej7_caso14_2]

red_test7_caso14 = (usuarios_ej7, relaciones_ej7, publicaciones_ej7_caso14)

-- redes para testear ejercicio 8: mínimo deben tener dos usuarios
usersF = [usuario7, usuario8]
relsF = [relacion7_8]
postsF1 = [publicacion7_1, publicacion8_1] -- True
postsF2 = [publicacion7_1, publicacion8_2] -- False, usuario8 no le dio like a su publicación
postsF3 = [publicacion7_2, publicacion8_3] -- False, hay una publicación sin likes
postsF4 = [publicacion7_3, publicacion8_3] -- True, las dos publicaciones sin likes
redF1 = (usersF, relsF, postsF1)
redF2 = (usersF, relsF, postsF2)
redF3 = (usersF, relsF, postsF3)
redF4 = (usersF, relsF, postsF4)

usersFA = [usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11]
postsFA = [publicacion5_1, publicacion6_1, publicacion7_1, publicacion8_1, publicacion9_1]
redFA = (usersFA, relsF, postsFA)

postsH = [publicacion2_1 , publicacion2_3]
redH = (usersA, [relacion1_2, relacion2_4], postsH)
redH1 = (usersA, [relacion1_2], postsH)
redH2 = (usersA, [relacion1_2], [publicacion1_1])
redH3 = (usersA, [relacion2_3], [publicacion3_2])
redH4 = ([usuario3], [], [])
redH5 = ([usuario3], [], [publicacion3_1])
redH6 = (usersA, [], [])
redH7 = (usersA, [], [publicacion1_1])
redH8 = (usersA, [], [publicacion1_1, publicacion1_2])
redH9 = (usersA, [], [publicacion1_1])
redH10 = (usersA, [], [publicacion1_1, publicacion3_1, publicacion4_1])
redH11 = ([usuario9], [], [publicacion9_2])


-- Redes para testear el ejercicio 10
usersG = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11, usuario12]
usersG2 = [usuario1, usuario2]
relsG2 = [relacion1_2]

redTodos0 = (usersG, [], [])

redG2a = (usersG2, [], [])
redG2b = (usersG2, relsG2, [])

relsTodos1 = [relacion1_3, relacion2_4]
redTodos1 = (usersG, relsTodos1, [])

relsTodos2 = [relacion1_3, relacion1_4, relacion2_5]
redTodos2 = (usersG, relsTodos2, [])

relsTodos3 = [relacion1_2, relacion1_3, relacion10_12, relacion11_12]
redTodos3 = (usersG, relsTodos3, [])

relsTodos4 = [relacion1_2, relacion1_3, relacion1_12, relacion10_12, relacion11_12]
redTodos4 = (usersG, relsTodos4, [])

relsTodos5 = [relacion1_2, relacion1_3, relacion3_12, relacion11_12]
redTodos5 = (usersG, relsTodos5, [])

relsTodos6 = [relacion1_2, relacion1_3, relacion3_4, relacion3_5, relacion5_6, relacion5_7, relacion5_8, relacion8_9, relacion8_10, relacion10_12, relacion11_12]
redTodos6 = (usersG, relsTodos6, [])

relsTodos7 = [relacion1_2, relacion1_3, relacion1_4, relacion3_4, relacion3_5, relacion4_5, relacion5_6, relacion5_7, relacion5_8, relacion7_8, relacion7_9, relacion8_9, relacion8_10, relacion10_12, relacion11_12]
redTodos7 = (usersG, relsTodos7, [])
