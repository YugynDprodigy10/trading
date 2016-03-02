CREATE TABLE trading_schema.analysis_properties
(
	id bigserial NOT NULL,
	name text NOT NULL,
	analysis_type character(1) NOT NULL,
	CONSTRAINT pk_analysis_properties PRIMARY KEY (id)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_properties
O	WNER TO trading;

-- NOTE:
-- trading_schema.analysis_properties requires a check constraint
-- analysis <T|D> (Time|Direction)

CREATE TABLE trading_schema.analysis_conditions
(
	id bigserial NOT NULL,
	analysis_property_id bigint NOT NULL,
	field_name text NOT NULL,
	operator text NOT NULL,
	threshold_type character(1) NOT NULL,
	duration interval,
	value numeric NOT NULL,
	CONSTRAINT pk_analysis_conditions PRIMARY KEY (id),
	CONSTRAINT fk_analysis_conditions FOREIGN KEY (analysis_property_id)
		REFERENCES trading_schema.analysis_properties (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_conditions
	OWNER TO trading;

-- NOTE:
-- trading_schema.analysis_conditions requires a check constraint
-- threshold_type<A|R> (Absolute|Relative)
-- operator <gt|lt|eq|lte|gte>


CREATE TABLE trading_schema.analysis_assignment_quote
(
	analysis_properties_id bigint NOT NULL,
	quote_id bigint NOT NULL,
	assigned_value numeric NOT NULL,
	CONSTRAINT pk_analysis_assignment_quote PRIMARY KEY (analysis_properties_id, quote_id),
	CONSTRAINT fk_analysis_assignment_quote_01 FOREIGN KEY (analysis_properties_id)
	REFERENCES trading_schema.analysis_properties (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_analysis_assignment_quote_02 FOREIGN KEY (quote_id)
		REFERENCES trading_schema.quote (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_assignment_quote
	OWNER TO trading;

