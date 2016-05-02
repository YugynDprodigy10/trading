
CREATE TABLE trading_schema.analysis_property
(
	id bigserial NOT NULL,
	name text NOT NULL,
	analysis_type character(1) NOT NULL,
	CONSTRAINT pk_analysis_property PRIMARY KEY (id)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_property
O	WNER TO trading;

-- NOTE:
-- trading_schema.analysis_property requires a check constraint
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
	status character(1) NOT NULL DEFAULT 'A'::bpchar,
	CONSTRAINT pk_analysis_conditions PRIMARY KEY (id),
	CONSTRAINT fk_analysis_conditions FOREIGN KEY (analysis_property_id)
		REFERENCES trading_schema.analysis_property (id) MATCH SIMPLE
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

-- Reference Table (to be used vaguely for versioning)
CREATE TABLE trading_schema.reference
(
	id bigserial NOT NULL,
	reference uuid NOT NULL,
	CONSTRAINT pk_reference PRIMARY KEY (id)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.reference
	OWNER TO trading;

-- Prediction Input

CREATE TABLE trading_schema.prediction_input
(
	analysis_property_id bigint NOT NULL,
	quote_id bigint NOT NULL,
	reference_id bigint,
	CONSTRAINT pk_analysis_assignment_quote PRIMARY KEY (analysis_property_id, quote_id),
	CONSTRAINT fk_analysis_assignment_quote_01 FOREIGN KEY (analysis_property_id)
		REFERENCES trading_schema.analysis_property (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_analysis_assignment_quote_02 FOREIGN KEY (quote_id)
		REFERENCES trading_schema.quote (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_reference FOREIGN KEY (reference_id)
		REFERENCES trading_schema.reference (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT uc_prediction_input UNIQUE (analysis_property_id, quote_id, reference_id)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_assignment_quote
	OWNER TO trading;
-- TODO: SET prediction_input.reference_id NOT NULL (once added to application)
