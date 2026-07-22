--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(40) NOT NULL,
    description text,
    is_spherical boolean,
    has_life boolean,
    age_in_millions_of_years integer,
    galaxy_types character varying(20) NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: galaxy_group; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_group (
    galaxy_group_id integer NOT NULL,
    name character varying(40) NOT NULL,
    galaxy_count integer
);


ALTER TABLE public.galaxy_group OWNER TO freecodecamp;

--
-- Name: galaxy_group_galaxy_group_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_group_galaxy_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_group_galaxy_group_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_group_galaxy_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_group_galaxy_group_id_seq OWNED BY public.galaxy_group.galaxy_group_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(40) NOT NULL,
    description text NOT NULL,
    is_spherical boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(40) NOT NULL,
    description text,
    is_spherical boolean,
    distance_from_earth numeric(10,2),
    has_life boolean,
    age_in_millions_of_years integer,
    planet_types character varying(20) NOT NULL,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(40) NOT NULL,
    description text NOT NULL,
    is_spherical boolean,
    distance_from_earth numeric(10,2),
    has_life boolean,
    age_in_millions_of_years integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_group galaxy_group_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_group ALTER COLUMN galaxy_group_id SET DEFAULT nextval('public.galaxy_group_galaxy_group_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'The home galaxy of Earth, containing billions of stars including the Sun.', false, true, 13600, 'Spiral');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'The closest major spiral galaxy to the Milky Way, located 2.5M light-years away.', false, false, 10000, 'Spiral');
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'A small spiral galaxy in the Local Group, third largest after Andromeda and Milky Way.', false, false, 12000, 'Spiral');
INSERT INTO public.galaxy VALUES (4, 'Large Magellanic Cloud', 'A satellite dwarf galaxy of the Milky Way with a disrupted structure.', false, false, 11000, 'Irregular');
INSERT INTO public.galaxy VALUES (5, 'Messier 87', 'A supergiant galaxy located in the Virgo Cluster with a supermassive black hole.', true, false, 13000, 'Elliptical');
INSERT INTO public.galaxy VALUES (6, 'Sombrero Galaxy', 'A unbarred spiral galaxy with a bright nucleus and a large central bulge.', false, false, 13200, 'Spiral');
INSERT INTO public.galaxy VALUES (7, 'Whirlpool Galaxy', 'A classic grand design spiral galaxy interacting with a smaller satellite galaxy.', false, false, 400, 'Spiral');
INSERT INTO public.galaxy VALUES (8, 'Cartwheel Galaxy', 'A rare ring galaxy formed after a high-speed collision between two galaxies.', false, false, 13000, 'Ring');
INSERT INTO public.galaxy VALUES (9, 'IC 1101', 'One of the largest known galaxies, located at the center of the Abell 2029 cluster.', true, false, 12300, 'Elliptical');
INSERT INTO public.galaxy VALUES (10, 'NGC 1427A', 'A dwarf galaxy undergoing intense star formation as it plummets into Fornax Cluster.', false, false, 10000, 'Irregular');


--
-- Data for Name: galaxy_group; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_group VALUES (1, 'local group', 50);
INSERT INTO public.galaxy_group VALUES (2, 'Stephan''s Quintet', 5);
INSERT INTO public.galaxy_group VALUES (3, 'Bullet Group', NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 'The only natural satellite of Earth, with a cratered surface and no atmosphere.', true, 1);
INSERT INTO public.moon VALUES (2, 'Phobos', 'A small irregular moon, heavily cratered, orbiting very close to Mars.', false, 2);
INSERT INTO public.moon VALUES (3, 'Deimos', 'A tiny irregular moon with a smooth surface, likely a captured asteroid.', false, 2);
INSERT INTO public.moon VALUES (4, 'Io', 'The most volcanically active body in the solar system, with a sulfur-rich surface.', true, 3);
INSERT INTO public.moon VALUES (5, 'Europa', 'An icy moon with a subsurface ocean, considered a prime candidate for life.', true, 3);
INSERT INTO public.moon VALUES (6, 'Ganymede', 'The largest moon in the solar system, with its own magnetic field.', true, 3);
INSERT INTO public.moon VALUES (7, 'Callisto', 'A heavily cratered icy moon, with a possible subsurface ocean.', true, 3);
INSERT INTO public.moon VALUES (8, 'Amalthea', 'An irregular small moon orbiting within Jupiter''s ring system.', false, 3);
INSERT INTO public.moon VALUES (9, 'Himalia', 'A small irregular moon, likely a captured asteroid, with a reddish color.', false, 3);
INSERT INTO public.moon VALUES (10, 'Thebe', 'An irregular small moon with a reddish surface, orbiting near Jupiter''s rings.', false, 3);
INSERT INTO public.moon VALUES (11, 'Titan', 'The only moon with a thick atmosphere, containing liquid methane lakes.', true, 4);
INSERT INTO public.moon VALUES (12, 'Rhea', 'An icy moon with a heavily cratered surface, second largest in Saturn system.', true, 4);
INSERT INTO public.moon VALUES (13, 'Iapetus', 'A two‑toned moon with a dark leading hemisphere and bright trailing side.', true, 4);
INSERT INTO public.moon VALUES (14, 'Dione', 'An icy moon with bright ice cliffs and a wispy terrain.', true, 4);
INSERT INTO public.moon VALUES (15, 'Tethys', 'An icy moon with a large crater Odysseus and a canyon system.', true, 4);
INSERT INTO public.moon VALUES (16, 'Enceladus', 'An icy moon with active geysers erupting from its subsurface ocean.', true, 4);
INSERT INTO public.moon VALUES (17, 'Mimas', 'An icy moon with a large crater Herschel, giving it a "Death Star" appearance.', true, 4);
INSERT INTO public.moon VALUES (18, 'Proxima b-I', 'A rocky moon with a thin atmosphere, likely tidally locked.', true, 5);
INSERT INTO public.moon VALUES (19, 'Proxima b-II', 'A small icy moon orbiting farther out, with a highly eccentric orbit.', true, 5);
INSERT INTO public.moon VALUES (20, 'R136a1 b-I', 'A dense rocky moon with a molten surface due to intense stellar radiation.', true, 7);
INSERT INTO public.moon VALUES (21, 'M31_V1 b-I', 'A large moon with a thin atmosphere and signs of volcanic activity.', true, 9);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 'Third planet from the Sun, the only known planet with liquid water and life.', true, 0.00, true, 4500, 'Terrestrial', 1);
INSERT INTO public.planet VALUES (2, 'Mars', 'Fourth planet, known as the Red Planet, with the largest volcano in the solar system.', true, 0.00, false, 4500, 'Terrestrial', 1);
INSERT INTO public.planet VALUES (3, 'Jupiter', 'The largest planet in the solar system, a gas giant with a Great Red Spot.', true, 0.00, false, 4500, 'Gas Giant', 1);
INSERT INTO public.planet VALUES (4, 'Saturn', 'Famous for its ring system, a gas giant with many moons.', true, 0.00, false, 4500, 'Gas Giant', 1);
INSERT INTO public.planet VALUES (5, 'Proxima b', 'An exoplanet orbiting in the habitable zone of Proxima Centauri, roughly Earth-sized.', true, 4.24, false, 4850, 'Terrestrial', 2);
INSERT INTO public.planet VALUES (6, 'Proxima c', 'A super-Earth or mini-Neptune candidate in the same system, farther out.', true, 4.24, false, 4850, 'Ice Giant', 2);
INSERT INTO public.planet VALUES (7, 'R136a1 b', 'A hot Jupiter orbiting extremely close to this massive star, tidally locked.', true, 163000.00, false, 1, 'Hot Jupiter', 3);
INSERT INTO public.planet VALUES (8, 'R136a1 c', 'A Neptune‑mass planet with a highly eccentric orbit, subject to intense radiation.', true, 163000.00, false, 1, 'Hot Neptune', 3);
INSERT INTO public.planet VALUES (9, 'M31_V1 b', 'A rocky world with a thin atmosphere, orbiting the Cepheid variable star.', true, 2530000.00, false, 10000, 'Terrestrial', 4);
INSERT INTO public.planet VALUES (10, 'M31_V1 c', 'A gas‑rich planet similar to Saturn, with a faint ring system.', true, 2530000.00, false, 10000, 'Gas Giant', 4);
INSERT INTO public.planet VALUES (11, 'M33_V1 b', 'An ice‑covered planet with a subsurface ocean, orbiting the Cepheid.', true, 3000000.00, false, 8000, 'Ice Giant', 5);
INSERT INTO public.planet VALUES (12, 'M33_V1 c', 'A dense terrestrial planet with volcanic activity, likely tidally heated.', true, 3000000.00, false, 8000, 'Terrestrial', 5);
INSERT INTO public.planet VALUES (13, 'M87_C1 b', 'A massive gas giant with a thick hydrogen‑helium atmosphere, orbiting a blue supergiant.', true, 53500000.00, false, 50, 'Gas Giant', 6);
INSERT INTO public.planet VALUES (14, 'M87_C1 c', 'A small dwarf planet with a highly inclined orbit, possibly captured.', true, 53500000.00, false, 50, 'Dwarf', 6);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'The star at the center of our Solar System, a G-type main-sequence star (G2V).', true, 0.00, false, 4600, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 'The closest known star to the Sun, a red dwarf in the Alpha Centauri system.', true, 4.24, false, 4850, 1);
INSERT INTO public.star VALUES (3, 'R136a1', 'One of the most massive and luminous stars known, located in the Tarantula Nebula of the Large Magellanic Cloud.', true, 163000.00, false, 1, 4);
INSERT INTO public.star VALUES (4, 'M31_V1', 'The first Cepheid variable star discovered in the Andromeda Galaxy by Edwin Hubble, used to measure its distance.', true, 2530000.00, false, 10000, 2);
INSERT INTO public.star VALUES (5, 'M33_V1', 'A Cepheid variable star in the Triangulum Galaxy, often used as a distance indicator for the Local Group.', true, 3000000.00, false, 8000, 3);
INSERT INTO public.star VALUES (6, 'M87_C1', 'A bright blue supergiant located in one of the globular clusters surrounding the supergiant elliptical galaxy M87.', true, 53500000.00, false, 50, 5);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 10, true);


--
-- Name: galaxy_group_galaxy_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_group_galaxy_group_id_seq', 3, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 14, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy_group galaxy_group_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_group
    ADD CONSTRAINT galaxy_group_name_key UNIQUE (name);


--
-- Name: galaxy_group galaxy_group_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_group
    ADD CONSTRAINT galaxy_group_pkey PRIMARY KEY (galaxy_group_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_start_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_start_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

