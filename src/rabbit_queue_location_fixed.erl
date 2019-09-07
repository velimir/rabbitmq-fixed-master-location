-module(rabbit_queue_location_fixed).

-behaviour(rabbit_queue_master_locator).

-include_lib("rabbit_common/include/rabbit.hrl").

-export([description/0, queue_master_location/1]).

-rabbit_boot_step({?MODULE,
                   [{description, "locate queue master with a configured node"},
                    {mfa,         {rabbit_registry, register,
                                   [queue_master_locator,
                                    <<"fixed">>, ?MODULE]}},
                    {requires,    rabbit_registry},
                    {enables,     kernel_ready}]}).


%%---------------------------------------------------------------------------
%% Queue Master Location Callbacks
%%---------------------------------------------------------------------------

description() ->
    [{description, <<"Place master queue on a configured node.">>}].

queue_master_location(#amqqueue{}) ->
    {ok, application:get_env(rabbit, master_node_location, node())}.
