CREATE OR REPLACE FUNCTION lotpg.countries_upsert(_country_id VARCHAR(3),
                                                  _title      VARCHAR(150),
                                                  _ch_type    VARCHAR(3))
    RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt     TIMESTAMP WITHOUT TIME ZONE;
    _error  VARCHAR(500);
    _result JSONB;
BEGIN
    _dt = NOW();
    _error = CONCAT('country_id: ', _country_id,
                    ', title: ', _title);

    IF _ch_type NOT IN ('CRT', 'UPD')
    THEN
        _result = JSONB_BUILD_OBJECT('Not valid type of action', _ch_type);
        RETURN _result;
    END IF;

    IF _ch_type = 'CRT'
    THEN
        IF EXISTS(SELECT 1
                  FROM lotpg.countries
                  WHERE country_id = _country_id)

        THEN
            _result = JSONB_BUILD_OBJECT('Country already exists', _error);
            RETURN _result;
        END IF;

        INSERT INTO lotpg.countries(country_id, title, ch_dt)
        SELECT _country_id,
               _title,
               _dt;
    END IF;

    IF _ch_type = 'UPD'
    THEN
        UPDATE lotpg.countries c
        SET title = _title,
            ch_dt = _dt
        WHERE c.country_id = _country_id;
    END IF;

    _result = JSONB_BUILD_OBJECT('title', (SELECT c.title
                                           FROM lotpg.countries c
                                           WHERE c.country_id = _country_id),
                                 'change_type', _ch_type);

    RETURN _result;
END;
$$;