module Solucion where

-- Completar con los datos del grupo
--
-- Nombre de Grupo: xx
-- Integrante 1: Ian Laiker, ianlaiker96@gmail.com, 192/15
-- Integrante 2: Evelyn Olszanowski, eve.olszanowski@gmail.com, 46/11
-- Integrante 3: Erik Alvarez, ejalvarezg@gmail.com, 1279/21
-- Integrante 4: Ignacio Mayansky, nachomayansky@gmail.com, 405/14

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas

usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id 

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us


--Ejercicio 1

-- nombresDeUsuarios recibe una red social valida y devuelve una lista de Strings con los nombres de todos los usuarios de la red
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios red = proyectarNombres (usuarios red)

-- proyectarNombres recibe una lista de usuarios validos y devuelve una lista de Strings con los nombres de los usuarios
proyectarNombres :: [Usuario] -> [String]
proyectarNombres [] = [] 
proyectarNombres (u:us) | pertenece (proyectarNombres us) (nombreDeUsuario u) = proyectarNombres us
                        | otherwise = [nombreDeUsuario u] ++ proyectarNombres us


-- Ejercicio 2

-- amigosDe recibe una red social valida y un usuario valido que pertenece a la red, y devuelve la lista de usuarios que son amigos de ese usuario en la red.
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe red u = buscarAmigos (relaciones red) u

-- buscarAmigos recibe una lista de relaciones de usuario validas y un usuario valido, y devuelve una lista de usuarios que comparten relacion con el usuario input 
buscarAmigos :: [Relacion] -> Usuario -> [Usuario]
buscarAmigos [] _ = [] 
buscarAmigos ((u1,u2):rs) u | u1 == u = [u2] ++ buscarAmigos rs u
                           -- u2 es amigo de u
                            | u2 == u = [u1] ++ buscarAmigos rs u
                           -- u1 es amigo de u
                            | otherwise = buscarAmigos rs u


-- Ejercicio 3

-- cantidadDeAmigos recibe una red social valida y un usuario valido que pertenece a la red, y devuelve la cantidad de amigos de ese usuario en la red
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red u = longitud (amigosDe red u)

-- longitud recibe una lista de elementos y devuelve un entero con la cantidad de elementos en la lista
longitud :: (Eq t) => [t] -> Int
longitud [] = 0
longitud (u:us) = 1 + longitud us



-- Ejercicio 4
-- la funcion "cantidadDeAmigos" esta implementada en el ejercicio 3

-- usuarioConMasAmigos Recibe una red social valida y devuelve el usuario de la red con mas amigos
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos red = compararCantidadDeAmigos (usuarios red) red

--compararCantidadDeAmigos recibe una red social valida y una lista de usuarios validos que pertenecen a la red, y devuelve el usuario que mas amigos tiene en esa lista de usuarios
compararCantidadDeAmigos :: [Usuario] -> RedSocial -> Usuario
compararCantidadDeAmigos [u] _ = u
compararCantidadDeAmigos (u1:u2:us) red | cantidadDeAmigos red u1 > cantidadDeAmigos red u2 = compararCantidadDeAmigos (u1:us) red
                                        | otherwise = compararCantidadDeAmigos (u2:us) red


-- Ejercicio 5
-- la funcion "cantidadDeAmigos" esta implementada en el ejercicio 3

--estaRobertoCarlos recibe una red social valida y devuelve True si existe un usuario con mas de 10 amigos en esa red (en realidad era mas de un millon de amigos)
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = masDeUnMillon red (usuarios red)


--masDeUnMillon recibe una red social valida y una lista de usuarios validos que pertenecen a la red, y devuelve True si existe un usuario de la lista de usuarios que tiene mas de 10 amigos
masDeUnMillon :: RedSocial -> [Usuario] -> Bool
masDeUnMillon _ [] = False
masDeUnMillon red (u:us) = cantidadDeAmigos red u > 10 || masDeUnMillon red us


-- Ejercicio 6

--publicacionesDe recibe una red social valida y un usuario valido que pertenece a la red, y devuelve una lista con las publicaciones que el usario hizo en esa red
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe redS u = buscarPublicacionesDe (publicaciones redS) u

--buscarPublicacionesDe recibe una lista de publicaciones validas y un usuario valido, y devuelve otra lista de publicaciones con aquellas publicaciones de la lista input que fueron realizadas por el usuario input
buscarPublicacionesDe :: [Publicacion] -> Usuario -> [Publicacion]
buscarPublicacionesDe [] _ = []
buscarPublicacionesDe (p:ps) u | usuarioDePublicacion p == u = [p] ++ buscarPublicacionesDe ps u
                               | otherwise = buscarPublicacionesDe ps u


-- Ejercicio 7

--publicacionesQueLeGustanA recibe una red social valida y un usuario valido que pertenece a la red, y devuelve una lista con todas las publicaciones de la red que le gustan al usuario input
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red u = sumDePublicacionesLikeadeas (publicaciones red) u

--sumDePublicacionesLikeadeas recibe una lista de publicaciones validas y un usuario valido, y devuelve una lista con las publicaciones de la lista input que fueron likeadas por el usuario input
sumDePublicacionesLikeadeas :: [Publicacion] -> Usuario -> [Publicacion]
sumDePublicacionesLikeadeas [] _ = []
sumDePublicacionesLikeadeas (p:ps) u | pertenece (likesDePublicacion p) u = [p] ++ sumDePublicacionesLikeadeas ps u 
                                     | otherwise = sumDePublicacionesLikeadeas ps u

--pertenece recibe una lista (cualquier tipo de dato) y un elemento (del mismo tipo que la lista), y devuelve True si el elemento esta presente en los elementos de la lista
pertenece :: (Eq t) => [t] -> t -> Bool
pertenece [] _ = False
pertenece (x:xs) e = e == x || pertenece xs e 


--Ejercicio 8
-- la función "publicacionesQueLeGustanA" esta definida en el ejercicio 7

-- Recibe una red social valida y dos usuarios validos que pertenecen a la red, y devuelve True si a los usuarios input u1 y u2 les gustan exactamente las mismas publicaciones en la red
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red u1 u2 | longitud pConLikeU1 == longitud pConLikeU2 = compararPublicacionesConLikes pConLikeU1 pConLikeU2
                                          | otherwise = False
                                          where pConLikeU1 = publicacionesQueLeGustanA red u1
                                                pConLikeU2 = publicacionesQueLeGustanA red u2

-- Examina si todas las publicaciones de (p:ps) están en la lista pubs
compararPublicacionesConLikes :: [Publicacion] -> [Publicacion] -> Bool
compararPublicacionesConLikes [] _ = True
compararPublicacionesConLikes (p:ps) pubs = pertenece pubs p && compararPublicacionesConLikes ps pubs

-- Alternativamente, se podría usar la función que sigue, considerando que el recorrido sobre las publicaciones siempre se hace de la misma manera
-- lesGustanLasMismasPublicaciones red u1 u2 = (publicacionesQueLeGustanA red u1) == (publicacionesQueLeGustanA red u2)


-- Ejercicio 9
--La funcion "pertenece" esta implementada en el ejercicio 7
--La funcion "publicacionesDe" esta implementada en el ejercicio 6

-- Recibe una red social valida y un usuario valido que pertenece a la red, y devuelve True si existe un usuario de la red que likea todas las publicaciones del usuario input
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel red u1 = buscarStalker (usuarios red) (publicacionesDe red u1) u1

--Recibe una lista de usuarios validos y una lista de publicaciones validas, y devuelve True si algun usuario de la lista de usuarios le dio like a todas las publicaciones de la lista de publicaciones (es decir, si la funcion esStalker da True para alguno de los usuarios)
buscarStalker :: [Usuario] -> [Publicacion] -> Usuario -> Bool
buscarStalker [] _ _ = False
buscarStalker (u:us) ps u1 = esStalker u ps u1 || buscarStalker us ps u1

--Recibe un usuario valido y una lista de publicaciones validas, y devuelve True si el usuario esta presente en la lista de usuarios que dieron like a una publicacion para todas las publicaciones de la lista de publicaciones input
esStalker :: Usuario -> [Publicacion] -> Usuario -> Bool
esStalker _ [] _ = False
esStalker u [p] u1 = u1 /= u && pertenece (likesDePublicacion p) u
esStalker u (p:ps) u1 = pertenece (likesDePublicacion p) u && esStalker u ps u1



--Ejercicio 10
--la funcion "amigosDe" esta definida en el ejercicio 2
--La funcion "pertenece" esta implementada en el ejercicio 7

--Recibe un red social valida y dos usuarios validos que pertenecen a la red, y devuelve True si existe una secuencia de relaciones directas entre el u1 y el u2, sin importar la cantidad de usuarios que hay en el medio.
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red u1 u2 = auxExisteSecuenciaDeAmigos red (amigosDe red u1) u2 []

--recibe una red social valida, dos listas de usuarios validos (us, xs) que pertenecen a la red y un usuario que pertenece a la red, y devuelve True si el usuario esta presente en us o en las listas de amigos de los usuarios de us
--Importante: en el peor de los casos la funcion recorre todos los usuarios de la lista us y todos los usuarios relacionados directa o indirectamente con los usuarios de us
--Importante: la lista xs acumula los usuarios ya visitados para no volver a visitarlos durante la recursion

-- auxExisteSecuenciaDeAmigos :: RedSocial -> [Usuario] -> Usuario -> [Usuario] -> Bool
-- auxExisteSecuenciaDeAmigos _ [] _ _ = False
-- auxExisteSecuenciaDeAmigos red (u1:us) u2 xs | u1 == u2 = True
--                                              | pertenece xs u1 = auxExisteSecuenciaDeAmigos red us u2 xs
--                                              | otherwise = (auxExisteSecuenciaDeAmigos red (amigosDe red u1) u2 (u1:xs)) || (auxExisteSecuenciaDeAmigos red us u2 (u1:xs))


auxExisteSecuenciaDeAmigos :: RedSocial -> [Usuario] -> Usuario -> [Usuario] -> Bool
auxExisteSecuenciaDeAmigos _ [] _ _ = False
auxExisteSecuenciaDeAmigos red (u1:us) u2 xs | pertenece (u1:us) u2 = True
                                             | pertenece xs u1 = auxExisteSecuenciaDeAmigos red us u2 xs --u1 está en xs, que es la lista de los usuarios ya visitados
                                             | otherwise = (auxExisteSecuenciaDeAmigos red (amigosDe red u1) u2 (u1:xs)) || (auxExisteSecuenciaDeAmigos red us u2 (u1:xs))

