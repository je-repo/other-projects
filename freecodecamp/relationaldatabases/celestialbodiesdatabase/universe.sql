--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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
-- Name: constellation; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.constellation (
    constellation_id integer NOT NULL,
    name character varying(50) DEFAULT ''::character varying NOT NULL,
    iau_abbreviation character varying(3) DEFAULT ''::character varying NOT NULL,
    galaxy_id integer
);


ALTER TABLE public.constellation OWNER TO freecodecamp;

--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.constellation_constellation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.constellation_constellation_id_seq OWNER TO freecodecamp;

--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.constellation_constellation_id_seq OWNED BY public.constellation.constellation_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_type text DEFAULT ''::text NOT NULL,
    radius_in_light_years integer DEFAULT 0 NOT NULL,
    number_of_stars integer DEFAULT 0 NOT NULL,
    age_in_billion_years numeric(6,2) DEFAULT 0 NOT NULL
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
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    diameter_in_km numeric(9,2) DEFAULT 0 NOT NULL,
    part_of_total_moons integer DEFAULT 0 NOT NULL,
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
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    length_of_day_in_hours integer DEFAULT 0 NOT NULL,
    mean_temperature_in_celsius integer DEFAULT 0 NOT NULL,
    number_of_moons integer DEFAULT 0 NOT NULL,
    has_ring_system boolean DEFAULT false NOT NULL,
    has_global_magnetic_field boolean DEFAULT false NOT NULL,
    is_dwarf_planet boolean DEFAULT false NOT NULL,
    star_id integer,
    galaxy_id integer
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
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    apparent_magnitude numeric(5,2) DEFAULT 0 NOT NULL,
    absolute_magnitude numeric(5,2) DEFAULT 0 NOT NULL,
    stellar_classification character varying(15) DEFAULT ''::character varying NOT NULL,
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
-- Name: constellation constellation_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation ALTER COLUMN constellation_id SET DEFAULT nextval('public.constellation_constellation_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


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
-- Data for Name: constellation; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.constellation VALUES (1, 'Andromeda', 'And', 1);
INSERT INTO public.constellation VALUES (2, 'Canes Venatici', 'CVn', 8);
INSERT INTO public.constellation VALUES (3, 'Corvus', 'Crv', 6);
INSERT INTO public.constellation VALUES (4, 'Dorado', 'Dor', 3);
INSERT INTO public.constellation VALUES (5, 'Draco', 'Dra', 7);
INSERT INTO public.constellation VALUES (6, 'Mensa', 'Men', 3);
INSERT INTO public.constellation VALUES (7, 'Sagittarius', 'Sgr', 4);
INSERT INTO public.constellation VALUES (8, 'Ursa Major', 'UMa', 2);
INSERT INTO public.constellation VALUES (9, 'Virgo', 'Vir', 6);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda', 'Barred Spiral Galaxy', 110000, 1000, 10.01);
INSERT INTO public.galaxy VALUES (2, 'Cigar Galaxy', 'Starburst Galaxy', 18500, 30, 13.30);
INSERT INTO public.galaxy VALUES (3, 'Large Magellanic Cloud', 'Dwarf Galaxy', 7000, 30, 1.10);
INSERT INTO public.galaxy VALUES (4, 'Milky Way', 'Barred Spiral Galaxy', 52850, 250, 13.61);
INSERT INTO public.galaxy VALUES (5, 'Pinwheel Galaxy', 'Face-On Unbarred Counterclockwise Spiral Galaxy', 85000, 1000, 0.00);
INSERT INTO public.galaxy VALUES (6, 'Sombrero Galaxy', 'Spiral Galaxy', 25000, 100, 13.25);
INSERT INTO public.galaxy VALUES (7, 'Tadpole Galaxy', 'Disrupted Barred Spiral Galaxy', 195000, 0, 0.10);
INSERT INTO public.galaxy VALUES (8, 'Whirlpool Galaxy', 'Interacting Grand Design Spiral Galaxy', 30000, 100, 0.40);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Amalthea', 167.00, 92, 5);
INSERT INTO public.moon VALUES (2, 'Callisto', 4816.80, 92, 5);
INSERT INTO public.moon VALUES (3, 'Deimos', 12.54, 2, 7);
INSERT INTO public.moon VALUES (4, 'Dione', 1122.80, 145, 11);
INSERT INTO public.moon VALUES (5, 'Elara', 79.90, 92, 5);
INSERT INTO public.moon VALUES (6, 'Enceladus', 504.20, 145, 11);
INSERT INTO public.moon VALUES (7, 'Europa', 3121.40, 92, 5);
INSERT INTO public.moon VALUES (8, 'Ganymede', 5268.20, 92, 5);
INSERT INTO public.moon VALUES (9, 'Himalia', 139.60, 92, 5);
INSERT INTO public.moon VALUES (10, 'Hyperion', 270.00, 145, 11);
INSERT INTO public.moon VALUES (11, 'Iapetus', 1468.80, 145, 11);
INSERT INTO public.moon VALUES (12, 'Io', 3636.20, 92, 5);
INSERT INTO public.moon VALUES (13, 'Metis', 43.00, 92, 5);
INSERT INTO public.moon VALUES (14, 'Mimas', 396.40, 145, 11);
INSERT INTO public.moon VALUES (15, 'Moon', 3474.80, 1, 2);
INSERT INTO public.moon VALUES (16, 'Oberon', 1522.80, 27, 12);
INSERT INTO public.moon VALUES (17, 'Pasiphae', 57.80, 92, 5);
INSERT INTO public.moon VALUES (18, 'Phobos', 22.16, 2, 7);
INSERT INTO public.moon VALUES (19, 'Phoebe', 213.00, 145, 11);
INSERT INTO public.moon VALUES (20, 'Proteus', 418.00, 14, 9);
INSERT INTO public.moon VALUES (21, 'Rhea', 1527.00, 145, 11);
INSERT INTO public.moon VALUES (22, 'Tethys', 1062.20, 145, 11);
INSERT INTO public.moon VALUES (23, 'Thebe', 98.60, 92, 5);
INSERT INTO public.moon VALUES (24, 'Titan', 5149.46, 145, 11);
INSERT INTO public.moon VALUES (25, 'Titania', 1577.80, 27, 12);
INSERT INTO public.moon VALUES (26, 'Triton', 2705.20, 14, 9);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Ceres', 9, -106, 0, false, false, true, 9, 4);
INSERT INTO public.planet VALUES (2, 'Earth', 24, 15, 1, false, true, false, 9, 4);
INSERT INTO public.planet VALUES (3, 'Eris', 379, -230, 1, false, false, true, 9, 4);
INSERT INTO public.planet VALUES (4, 'Haumea', 4, -220, 2, false, false, true, 9, 4);
INSERT INTO public.planet VALUES (5, 'Jupiter', 10, -110, 95, true, true, false, 9, 4);
INSERT INTO public.planet VALUES (6, 'Makemake', 23, -230, 1, false, false, true, 9, 4);
INSERT INTO public.planet VALUES (7, 'Mars', 25, -65, 2, false, false, false, 9, 4);
INSERT INTO public.planet VALUES (8, 'Mercury', 4223, 167, 0, false, true, false, 9, 4);
INSERT INTO public.planet VALUES (9, 'Neptune', 16, -200, 16, true, true, false, 9, 4);
INSERT INTO public.planet VALUES (10, 'Pluto', 153, -229, 5, false, false, true, 9, 4);
INSERT INTO public.planet VALUES (11, 'Saturn', 11, -140, 146, true, true, false, 9, 4);
INSERT INTO public.planet VALUES (12, 'Uranus', 17, -195, 28, true, true, false, 9, 4);
INSERT INTO public.planet VALUES (13, 'Venus', 2802, 464, 0, false, false, false, 9, 4);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Alpheratz', 2.07, -0.30, 'B9p', 1);
INSERT INTO public.star VALUES (2, 'Mirach', 2.07, -1.86, 'M0IIIvar', 1);
INSERT INTO public.star VALUES (3, 'V428 And', 5.14, -1.38, 'K5III', 1);
INSERT INTO public.star VALUES (4, 'Cor Caroli', 2.89, 0.25, 'A0spe...', 8);
INSERT INTO public.star VALUES (5, 'HD 107418', 5.15, 1.24, 'K0III', 6);
INSERT INTO public.star VALUES (6, 'HD 40409', 4.65, 2.72, 'K1III/IV', 3);
INSERT INTO public.star VALUES (7, 'HD 81817', 4.28, -3.31, 'K3III', 7);
INSERT INTO public.star VALUES (8, 'Sakurai''s Object', 11.60, 0.00, 'F2Ia C~', 4);
INSERT INTO public.star VALUES (9, 'Sun', -26.74, 4.83, 'G2V', 4);


--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.constellation_constellation_id_seq', 9, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 8, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 26, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: constellation constellation_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_name_unique UNIQUE (name);


--
-- Name: constellation constellation_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_pkey PRIMARY KEY (constellation_id);


--
-- Name: galaxy galaxy_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_unique UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_unique UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_unique UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_unique UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: constellation fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: planet fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

