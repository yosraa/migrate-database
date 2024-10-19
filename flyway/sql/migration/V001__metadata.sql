CREATE TABLE IF NOT EXISTS uber_request_logs (
    request_id serial primary key ,
    request_date TIMESTAMP WITH TIME ZONE NOT NULL,
    request_status varchar,
    distance_to_travel float ,
    monetary_cost float,
    driver_to_client_distance float
);
