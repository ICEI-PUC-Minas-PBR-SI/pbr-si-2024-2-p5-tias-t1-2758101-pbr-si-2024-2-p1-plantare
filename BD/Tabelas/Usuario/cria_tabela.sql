CREATE TABLE public."Usuario"
(
    "UsuarioID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "Nome" character varying(60) NOT NULL,
    "Email" character varying(50) NOT NULL,
    "Senha" character varying(64) NOT NULL,
    PRIMARY KEY ("UsuarioID"),
    UNIQUE ("UsuarioID")
);

ALTER TABLE IF EXISTS public."Usuario"
    OWNER to postgres;