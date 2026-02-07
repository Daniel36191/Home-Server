updatenix --show-trace
> Updating all flake inputs
warning: Git tree '/home/daniel/Nixos_V2' is dirty
warning: redirecting to https://git.outfoxxed.me/quickshell/quickshell/
> Building NixOS configuration
warning: Git tree '/home/daniel/Nixos_V2' is dirty
evaluation warning: dank-material-shell: flake output `homeModules.dankMaterialShell.default` has been renamed to `homeModules.dank-material-shell`
error:
       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1708:17:
         1707|         zipAttrsWith (
         1708|           name: values:
             |                 ^
         1709|           let

       … while calling the 'head' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1713:13:
         1712|           if length values == 1 || pred here (elemAt values 1) (head values) then
         1713|             head values
             |             ^
         1714|           else

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `system.build.toplevel':

       … while evaluating the attribute 'mergedValue'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1192:5:
         1191|     # Type-check the remaining definitions, and merge them. Or throw if no definitions.
         1192|     mergedValue =
             |     ^
         1193|       if isDefined then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1193:7:
         1192|     mergedValue =
         1193|       if isDefined then
             |       ^
         1194|         if type.merge ? v2 then

       … while evaluating the attribute 'values'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1186:9:
         1185|       {
         1186|         values = defsSorted;
             |         ^
         1187|         inherit (defsFiltered) highestPrio;

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1180:11:
         1179|           # Avoid sorting if we don't have to.
         1180|           if any (def: def.value._type or "" == "order") defsFiltered.values then
             |           ^
         1181|             sortProperties defsFiltered.values

       … while calling the 'any' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1180:14:
         1179|           # Avoid sorting if we don't have to.
         1180|           if any (def: def.value._type or "" == "order") defsFiltered.values then
             |              ^
         1181|             sortProperties defsFiltered.values

       … while evaluating the attribute 'values'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1360:7:
         1359|     {
         1360|       values = concatMap (def: if getPrio def == highestPrio then [ (strip def) ] else [ ]) defs;
             |       ^
         1361|       inherit highestPrio;

       … while calling the 'concatMap' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1360:16:
         1359|     {
         1360|       values = concatMap (def: if getPrio def == highestPrio then [ (strip def) ] else [ ]) defs;
             |                ^
         1361|       inherit highestPrio;

       … while calling the 'concatMap' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1160:26:
         1159|         # Process mkMerge and mkIf properties.
         1160|         defsNormalized = concatMap (
             |                          ^
         1161|           m:

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1161:11:
         1160|         defsNormalized = concatMap (
         1161|           m:
             |           ^
         1162|           map (

       … while calling the 'map' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1162:11:
         1161|           m:
         1162|           map (
             |           ^
         1163|             value:

       … while evaluating definitions from `/nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/activation/top-level.nix':

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1171:80:
         1170|               }
         1171|           ) (addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                ^
         1172|         ) defs;

       … while calling 'dischargeProperties'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1311:5:
         1310|   dischargeProperties =
         1311|     def:
             |     ^
         1312|     if def._type or "" == "merge" then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1312:5:
         1311|     def:
         1312|     if def._type or "" == "merge" then
             |     ^
         1313|       concatMap dischargeProperties def.contents

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:805:21:
          804|             inherit (module) file;
          805|             inherit value;
             |                     ^
          806|           }) module.config

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/activation/top-level.nix:76:26:
           75|   # Handle assertions and warnings
           76|   baseSystemAssertWarn = lib.asserts.checkAssertWarn config.assertions config.warnings baseSystem;
             |                          ^
           77|

       … while calling 'checkAssertWarn'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/asserts.nix:193:27:
          192|   checkAssertWarn =
          193|     assertions: warnings: val:
             |                           ^
          194|     let

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/asserts.nix:200:7:
          199|     else
          200|       showWarnings warnings val;
             |       ^
          201|

       … while calling 'showWarnings'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/trivial.nix:989:28:
          988|
          989|   showWarnings = warnings: res: lib.foldr (w: x: warn w x) res warnings;
             |                            ^
          990|

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/trivial.nix:989:33:
          988|
          989|   showWarnings = warnings: res: lib.foldr (w: x: warn w x) res warnings;
             |                                 ^
          990|

       … while calling 'foldr'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:138:14:
          137|   foldr =
          138|     op: nul: list:
             |              ^
          139|     let

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:143:5:
          142|     in
          143|     fold' 0;
             |     ^
          144|

       … while calling 'fold''
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:141:15:
          140|       len = length list;
          141|       fold' = n: if n == len then nul else op (elemAt list n) (fold' (n + 1));
             |               ^
          142|     in

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:141:18:
          140|       len = length list;
          141|       fold' = n: if n == len then nul else op (elemAt list n) (fold' (n + 1));
             |                  ^
          142|     in

       … while calling the 'length' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:140:13:
          139|     let
          140|       len = length list;
             |             ^
          141|       fold' = n: if n == len then nul else op (elemAt list n) (fold' (n + 1));

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/activation/top-level.nix:76:72:
           75|   # Handle assertions and warnings
           76|   baseSystemAssertWarn = lib.asserts.checkAssertWarn config.assertions config.warnings baseSystem;
             |                                                                        ^
           77|

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `warnings':

       (10 duplicate frames omitted)

       … while evaluating definitions from `/nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix':

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1171:80:
         1170|               }
         1171|           ) (addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                ^
         1172|         ) defs;

       … while calling 'dischargeProperties'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1311:5:
         1310|   dischargeProperties =
         1311|     def:
             |     ^
         1312|     if def._type or "" == "merge" then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1312:5:
         1311|     def:
         1312|     if def._type or "" == "merge" then
             |     ^
         1313|       concatMap dischargeProperties def.contents

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:805:21:
          804|             inherit (module) file;
          805|             inherit value;
             |                     ^
          806|           }) module.config

       … while calling the 'concatLists' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix:502:7:
          501|       in
          502|       concatLists (
             |       ^
          503|         mapAttrsToList (

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix:504:17:
          503|         mapAttrsToList (
          504|           name: service:
             |                 ^
          505|           let

       … while calling the 'concatLists' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix:510:11:
          509|           in
          510|           concatLists [
             |           ^
          511|             (optional (type == "oneshot" && (restart == "always" || restart == "on-success"))

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix:511:14:
          510|           concatLists [
          511|             (optional (type == "oneshot" && (restart == "always" || restart == "on-success"))
             |              ^
          512|               "Service '${name}.service' with 'Type=oneshot' cannot have 'Restart=always' or 'Restart=on-success'"

       … while calling 'optional'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:779:20:
          778|   */
          779|   optional = cond: elem: if cond then [ elem ] else [ ];
             |                    ^
          780|

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/lists.nix:779:26:
          778|   */
          779|   optional = cond: elem: if cond then [ elem ] else [ ];
             |                          ^
          780|

       … in the left operand of the AND (&&) operator
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix:511:42:
          510|           concatLists [
          511|             (optional (type == "oneshot" && (restart == "always" || restart == "on-success"))
             |                                          ^
          512|               "Service '${name}.service' with 'Type=oneshot' cannot have 'Restart=always' or 'Restart=on-success'"

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/nixos/modules/system/boot/systemd.nix:506:20:
          505|           let
          506|             type = service.serviceConfig.Type or "";
             |                    ^
          507|             restart = service.serviceConfig.Restart or "no";

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `systemd.services.home-manager-daniel.serviceConfig':

       … while evaluating the attribute 'mergedValue'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1192:5:
         1191|     # Type-check the remaining definitions, and merge them. Or throw if no definitions.
         1192|     mergedValue =
             |     ^
         1193|       if isDefined then

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/types.nix:879:13:
          878|             headError = checkDefsForError check loc defs;
          879|             value = mapAttrs (
             |             ^
          880|               n: v:

       … while calling the 'mapAttrs' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/types.nix:879:21:
          878|             headError = checkDefsForError check loc defs;
          879|             value = mapAttrs (
             |                     ^
          880|               n: v:

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/types.nix:873:17:
          872|                 # Meaning it is less lazy
          873|                 filterAttrs (n: v: v.optionalValue ? value) (
             |                 ^
          874|                   zipAttrsWith (name: defs: mergeDefinitions (loc ++ [ name ]) elemType defs) (pushPositions defs)

       … while calling 'filterAttrs'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:663:23:
          662|   */
          663|   filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
             |                       ^
          664|

       … while calling the 'removeAttrs' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:663:28:
          662|   */
          663|   filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
             |                            ^
          664|

       … while calling the 'filter' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:663:45:
          662|   */
          663|   filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
             |                                             ^
          664|

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:663:53:
          662|   */
          663|   filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
             |                                                     ^
          664|

       … in the argument of the not operator
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:663:60:
          662|   */
          663|   filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
             |                                                            ^
          664|

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:663:60:
          662|   */
          663|   filterAttrs = pred: set: removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
             |                                                            ^
          664|

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/types.nix:873:33:
          872|                 # Meaning it is less lazy
          873|                 filterAttrs (n: v: v.optionalValue ? value) (
             |                                 ^
          874|                   zipAttrsWith (name: defs: mergeDefinitions (loc ++ [ name ]) elemType defs) (pushPositions defs)

       … while evaluating the attribute 'optionalValue'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1256:5:
         1255|
         1256|     optionalValue = if isDefined then { value = mergedValue; } else { };
             |     ^
         1257|   };

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1256:21:
         1255|
         1256|     optionalValue = if isDefined then { value = mergedValue; } else { };
             |                     ^
         1257|   };

       (8 duplicate frames omitted)

       … while evaluating definitions from `/nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/nixos':

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1171:80:
         1170|               }
         1171|           ) (addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                ^
         1172|         ) defs;

       … while calling 'dischargeProperties'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1311:5:
         1310|   dischargeProperties =
         1311|     def:
             |     ^
         1312|     if def._type or "" == "merge" then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1312:5:
         1311|     def:
         1312|     if def._type or "" == "merge" then
             |     ^
         1313|       concatMap dischargeProperties def.contents

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/types.nix:820:11:
          819|           inherit (def) file;
          820|           value = v;
             |           ^
          821|         }) def.value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/types.nix:820:11:
          819|           inherit (def) file;
          820|           value = v;
             |           ^
          821|         }) def.value

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1708:17:
         1707|         zipAttrsWith (
         1708|           name: values:
             |                 ^
         1709|           let

       … while calling the 'head' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1713:13:
         1712|           if length values == 1 || pred here (elemAt values 1) (head values) then
         1713|             head values
             |             ^
         1714|           else

       … while calling the 'getAttr' builtin
         at <nix/derivation-internal.nix>:50:17:
           49|     value = commonAttrs // {
           50|       outPath = builtins.getAttr outputName strict;
             |                 ^
           51|       drvPath = strict.drvPath;

       … while calling the 'derivationStrict' builtin
         at <nix/derivation-internal.nix>:37:12:
           36|
           37|   strict = derivationStrict drvAttrs;
             |            ^
           38|

       … while evaluating derivation 'home-manager-generation'
         whose name attribute is located at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/pkgs/stdenv/generic/make-derivation.nix:536:13

       … while evaluating attribute 'buildCommand' of derivation 'home-manager-generation'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/pkgs/build-support/trivial-builders/default.nix:80:17:
           79|         enableParallelBuilding = true;
           80|         inherit buildCommand name;
             |                 ^
           81|         passAsFile = [ "buildCommand" ] ++ (derivationArgs.passAsFile or [ ]);

       … while calling the 'getAttr' builtin
         at <nix/derivation-internal.nix>:50:17:
           49|     value = commonAttrs // {
           50|       outPath = builtins.getAttr outputName strict;
             |                 ^
           51|       drvPath = strict.drvPath;

       … while calling the 'derivationStrict' builtin
         at <nix/derivation-internal.nix>:37:12:
           36|
           37|   strict = derivationStrict drvAttrs;
             |            ^
           38|

       … while evaluating derivation 'activation-script'
         whose name attribute is located at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/pkgs/stdenv/generic/make-derivation.nix:536:13

       … while evaluating attribute 'text' of derivation 'activation-script'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/pkgs/build-support/trivial-builders/default.nix:129:13:
          128|           inherit
          129|             text
             |             ^
          130|             executable

       … while calling the 'concatStringsSep' builtin
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/home-environment.nix:774:13:
          773|           if sortedCommands ? result then
          774|             lib.concatStringsSep "\n" (map mkCmd sortedCommands.result)
             |             ^
          775|           else

       … while calling 'mkCmd'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/home-environment.nix:767:17:
          766|       let
          767|         mkCmd = res: ''
             |                 ^
          768|           _iNote "Activating %s" "${res.name}"

       … while evaluating the attribute 'data'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/dag.nix:100:45:
           99|       {
          100|         result = map (v: { inherit (v) name data; }) sorted.result;
             |                                             ^
          101|       }

       … while evaluating the attribute 'data'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/dag.nix:92:9:
           91|         name = n;
           92|         data = v.data;
             |         ^
           93|         after = v.after ++ dagBefore dag n;

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/dag.nix:92:16:
           91|         name = n;
           92|         data = v.data;
             |                ^
           93|         after = v.after ++ dagBefore dag n;

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `home-manager.users.daniel.home.activation.checkFilesChanged.data':

       (10 duplicate frames omitted)

       … while evaluating definitions from `/nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix':

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1171:80:
         1170|               }
         1171|           ) (addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                ^
         1172|         ) defs;

       … while calling 'dischargeProperties'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1311:5:
         1310|   dischargeProperties =
         1311|     def:
             |     ^
         1312|     if def._type or "" == "merge" then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1312:5:
         1311|     def:
         1312|     if def._type or "" == "merge" then
             |     ^
         1313|       concatMap dischargeProperties def.contents

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:805:21:
          804|             inherit (module) file;
          805|             inherit value;
             |                     ^
          806|           }) module.config

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:259:9:
          258|       ''
          259|       + lib.concatMapStrings (
             |         ^
          260|         v:

       … while calling 'concatMapStrings'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:125:25:
          124|   */
          125|   concatMapStrings = f: list: concatStrings (map f list);
             |                         ^
          126|

       … while calling the 'concatStringsSep' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:125:31:
          124|   */
          125|   concatMapStrings = f: list: concatStrings (map f list);
             |                               ^
          126|

       … while calling anonymous lambda
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:260:9:
          259|       + lib.concatMapStrings (
          260|         v:
             |         ^
          261|         let

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:262:23:
          261|         let
          262|           sourceArg = lib.escapeShellArg (sourceStorePath v);
             |                       ^
          263|           targetArg = lib.escapeShellArg v.target;

       … while calling 'escapeShellArg'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:1202:5:
         1201|   escapeShellArg =
         1202|     arg:
             |     ^
         1203|     let

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:1206:5:
         1205|     in
         1206|     if match "[[:alnum:],._+:@%/-]+" string == null then
             |     ^
         1207|       "'${replaceString "'" "'\\''" string}'"

       … while calling the 'match' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:1206:8:
         1205|     in
         1206|     if match "[[:alnum:],._+:@%/-]+" string == null then
             |        ^
         1207|       "'${replaceString "'" "'\\''" string}'"

       … while evaluating the second argument passed to builtins.match

       … while calling the 'toString' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:1204:16:
         1203|     let
         1204|       string = toString arg;
             |                ^
         1205|     in

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:262:43:
          261|         let
          262|           sourceArg = lib.escapeShellArg (sourceStorePath v);
             |                                           ^
          263|           targetArg = lib.escapeShellArg v.target;

       … while calling 'sourceStorePath'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:20:5:
           19|   sourceStorePath =
           20|     file:
             |     ^
           21|     let

       … while evaluating a branch condition
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:25:5:
           24|     in
           25|     if builtins.hasContext sourcePath then
             |     ^
           26|       file.source

       … while calling the 'hasContext' builtin
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:25:8:
           24|     in
           25|     if builtins.hasContext sourcePath then
             |        ^
           26|       file.source

       … while evaluating the argument passed to builtins.hasContext

       … while calling the 'toString' builtin
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:22:20:
           21|     let
           22|       sourcePath = toString file.source;
             |                    ^
           23|       sourceName = config.lib.strings.storeFileName (baseNameOf sourcePath);

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/files.nix:22:29:
           21|     let
           22|       sourcePath = toString file.source;
             |                             ^
           23|       sourceName = config.lib.strings.storeFileName (baseNameOf sourcePath);

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `home-manager.users.daniel.home.file."/home/daniel/.config/hypr/hyprland.conf".source':

       (13 duplicate frames omitted)

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1315:7:
         1314|     else if def._type or "" == "if" then
         1315|       if isBool def.condition then
             |       ^
         1316|         if def.condition then dischargeProperties def.content else [ ]

       … while calling the 'isBool' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1315:10:
         1314|     else if def._type or "" == "if" then
         1315|       if isBool def.condition then
             |          ^
         1316|         if def.condition then dischargeProperties def.content else [ ]

       … while evaluating the attribute 'condition'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1471:13:
         1470|     _type = "if";
         1471|     inherit condition content;
             |             ^
         1472|   };

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/file-type.nix:145:28:
          144|             target = mkDefault name;
          145|             source = mkIf (config.text != null) (
             |                            ^
          146|               mkDefault (

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `home-manager.users.daniel.home.file."/home/daniel/.config/hypr/hyprland.conf".text':

       (10 duplicate frames omitted)

       … while evaluating definitions from `/nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/misc/xdg.nix':

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1171:80:
         1170|               }
         1171|           ) (addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                ^
         1172|         ) defs;

       … while calling 'dischargeProperties'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1311:5:
         1310|   dischargeProperties =
         1311|     def:
             |     ^
         1312|     if def._type or "" == "merge" then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1312:5:
         1311|     def:
         1312|     if def._type or "" == "merge" then
             |     ^
         1313|       concatMap dischargeProperties def.contents

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:805:21:
          804|             inherit (module) file;
          805|             inherit value;
             |                     ^
          806|           }) module.config

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:805:21:
          804|             inherit (module) file;
          805|             inherit value;
             |                     ^
          806|           }) module.config

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1188:17:
         1187|         mapAttrs (
         1188|           name: value:
             |                 ^
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/attrsets.nix:1189:85:
         1188|           name: value:
         1189|           if isAttrs value && cond value then recurse (path ++ [ name ]) value else f (path ++ [ name ]) value
             |                                                                                     ^
         1190|         );

       … while calling anonymous lambda
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:275:71:
          274|           # For definitions that have an associated option
          275|           declaredConfig = mapAttrsRecursiveCond (v: !isOption v) (_: v: v.value) options;
             |                                                                       ^
          276|

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1118:7:
         1117|     // {
         1118|       value = addErrorContext "while evaluating the option `${showOption loc}':" value;
             |       ^
         1119|       inherit (res.defsFinal') highestPrio;

       … while evaluating the option `home-manager.users.daniel.xdg.configFile."hypr/hyprland.conf".text':

       (10 duplicate frames omitted)

       … while evaluating definitions from `/nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix':

       … from call site
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1171:80:
         1170|               }
         1171|           ) (addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                ^
         1172|         ) defs;

       … while calling 'dischargeProperties'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1311:5:
         1310|   dischargeProperties =
         1311|     def:
             |     ^
         1312|     if def._type or "" == "merge" then

       … while evaluating a branch condition
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:1312:5:
         1311|     def:
         1312|     if def._type or "" == "merge" then
             |     ^
         1313|       concatMap dischargeProperties def.contents

       … while evaluating the attribute 'value'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/modules.nix:805:21:
          804|             inherit (module) file;
          805|             inherit value;
             |                     ^
          806|           }) module.config

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:408:13:
          407|           lib.optionalString cfg.systemd.enable systemdActivation
          408|           + lib.optionalString (cfg.plugins != [ ]) (pluginsToHyprconf cfg.plugins)
             |             ^
          409|           + lib.optionalString (cfg.settings != { }) (

       … while calling 'optionalString'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:767:26:
          766|   */
          767|   optionalString = cond: string: if cond then string else "";
             |                          ^
          768|

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:408:54:
          407|           lib.optionalString cfg.systemd.enable systemdActivation
          408|           + lib.optionalString (cfg.plugins != [ ]) (pluginsToHyprconf cfg.plugins)
             |                                                      ^
          409|           + lib.optionalString (cfg.settings != { }) (

       … while calling 'pluginsToHyprconf'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:380:11:
          379|         pluginsToHyprconf =
          380|           plugins:
             |           ^
          381|           lib.hm.generators.toHyprconf {

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:381:11:
          380|           plugins:
          381|           lib.hm.generators.toHyprconf {
             |           ^
          382|             attrs = {

       … while calling 'toHyprconf'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:5:5:
            4|   toHyprconf =
            5|     {
             |     ^
            6|       attrs,

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:67:5:
           66|     in
           67|     toHyprconf' initialIndent attrs;
             |     ^
           68|

       … while calling 'toHyprconf''
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:30:17:
           29|       toHyprconf' =
           30|         indent: attrs:
             |                 ^
           31|         let

       … while calling the 'concatStringsSep' builtin
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:64:11:
           63|         mkFields importantFields
           64|         + concatStringsSep "\n" (mapAttrsToList mkSection sections)
             |           ^
           65|         + mkFields fields;

       … while calling 'mkSection'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:41:16:
           40|           mkSection =
           41|             n: attrs:
             |                ^
           42|             if isList attrs then

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:46:16:
           45|               in
           46|               (concatMapStringsSep separator (a: mkSection n a) attrs)
             |                ^
           47|             else if isAttrs attrs then

       … while calling 'concatMapStringsSep'
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:262:13:
          261|   concatMapStringsSep =
          262|     sep: f: list:
             |             ^
          263|     concatStringsSep sep (map f list);

       … while calling the 'concatStringsSep' builtin
         at /nix/store/9ddbmv9s0h6092m1fi85rv2vv32165lp-source/lib/strings.nix:263:5:
          262|     sep: f: list:
          263|     concatStringsSep sep (map f list);
             |     ^
          264|

       … while evaluating the first argument (the separator string) passed to builtins.concatStringsSep

       … while evaluating a branch condition
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:44:29:
           43|               let
           44|                 separator = if all isAttrs attrs then "\n" else "";
             |                             ^
           45|               in

       … while calling the 'all' builtin
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/lib/generators.nix:44:32:
           43|               let
           44|                 separator = if all isAttrs attrs then "\n" else "";
             |                                ^
           45|               in

       … while calling the 'isAttrs' builtin

       … while calling anonymous lambda
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:388:22:
          387|                 in
          388|                 map (p: "hyprctl plugin load ${mkEntry p}") cfg.plugins;
             |                      ^
          389|             };

       … from call site
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:388:48:
          387|                 in
          388|                 map (p: "hyprctl plugin load ${mkEntry p}") cfg.plugins;
             |                                                ^
          389|             };

       … while calling 'mkEntry'
         at /nix/store/nqjhl7f36qjvc7kcr1pcp6nxbl6cs1qv-source/modules/services/window-managers/hyprland.nix:386:21:
          385|                   mkEntry =
          386|                     entry: if lib.types.package.check entry then "${entry}/lib/lib${entry.pname}.so" else entry;
             |                     ^
          387|                 in

       … while calling the 'getAttr' builtin
         at <nix/derivation-internal.nix>:50:17:
           49|     value = commonAttrs // {
           50|       outPath = builtins.getAttr outputName strict;
             |                 ^
           51|       drvPath = strict.drvPath;

       … while calling the 'derivationStrict' builtin
         at <nix/derivation-internal.nix>:37:12:
           36|
           37|   strict = derivationStrict drvAttrs;
             |            ^
           38|

       … while evaluating derivation 'hyprsplit-flakeRev=6434862_srcRev=git'
         whose name attribute is located at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:331:7

       … while evaluating attribute 'nativeBuildInputs' of derivation 'hyprsplit-flakeRev=6434862_srcRev=git'
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:375:7:
          374|       depsBuildBuild              = elemAt (elemAt dependencies 0) 0;
          375|       nativeBuildInputs           = elemAt (elemAt dependencies 0) 1;
             |       ^
          376|       depsBuildTarget             = elemAt (elemAt dependencies 0) 2;

       … while calling anonymous lambda
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:302:13:
          301|       (map (drv: getDev drv.__spliced.buildBuild or drv) (checkDependencyList "depsBuildBuild" depsBuildBuild))
          302|       (map (drv: getDev drv.__spliced.buildHost or drv) (checkDependencyList "nativeBuildInputs" nativeBuildInputs'))
             |             ^
          303|       (map (drv: getDev drv.__spliced.buildTarget or drv) (checkDependencyList "depsBuildTarget" depsBuildTarget))

       … from call site
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:302:18:
          301|       (map (drv: getDev drv.__spliced.buildBuild or drv) (checkDependencyList "depsBuildBuild" depsBuildBuild))
          302|       (map (drv: getDev drv.__spliced.buildHost or drv) (checkDependencyList "nativeBuildInputs" nativeBuildInputs'))
             |                  ^
          303|       (map (drv: getDev drv.__spliced.buildTarget or drv) (checkDependencyList "depsBuildTarget" depsBuildTarget))

       … while calling 'getOutput'
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/attrsets.nix:1762:23:
         1761|   */
         1762|   getOutput = output: pkg:
             |                       ^
         1763|     if ! pkg ? outputSpecified || ! pkg.outputSpecified

       … while evaluating a branch condition
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/attrsets.nix:1763:5:
         1762|   getOutput = output: pkg:
         1763|     if ! pkg ? outputSpecified || ! pkg.outputSpecified
             |     ^
         1764|       then pkg.${output} or pkg.out or pkg

       … in the left operand of the OR (||) operator
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/attrsets.nix:1763:32:
         1762|   getOutput = output: pkg:
         1763|     if ! pkg ? outputSpecified || ! pkg.outputSpecified
             |                                ^
         1764|       then pkg.${output} or pkg.out or pkg

       … in the argument of the not operator
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/attrsets.nix:1763:10:
         1762|   getOutput = output: pkg:
         1763|     if ! pkg ? outputSpecified || ! pkg.outputSpecified
             |          ^
         1764|       then pkg.${output} or pkg.out or pkg

       … from call site
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:302:25:
          301|       (map (drv: getDev drv.__spliced.buildBuild or drv) (checkDependencyList "depsBuildBuild" depsBuildBuild))
          302|       (map (drv: getDev drv.__spliced.buildHost or drv) (checkDependencyList "nativeBuildInputs" nativeBuildInputs'))
             |                         ^
          303|       (map (drv: getDev drv.__spliced.buildTarget or drv) (checkDependencyList "depsBuildTarget" depsBuildTarget))

       … while calling anonymous lambda
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/lists.nix:334:29:
          333|   */
          334|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
             |                             ^
          335|

       … from call site
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/lists.nix:334:32:
          333|   */
          334|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
             |                                ^
          335|

       … while calling anonymous lambda
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:276:15:
          275|     imap1
          276|       (index: dep:
             |               ^
          277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep

       … while evaluating a branch condition
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:9:
          276|       (index: dep:
          277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
             |         ^
          278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep

       … in the left operand of the OR (||) operator
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:69:
          276|       (index: dep:
          277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
             |                                                                     ^
          278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep

       … in the left operand of the OR (||) operator
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:44:
          276|       (index: dep:
          277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
             |                                            ^
          278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep

       … in the left operand of the OR (||) operator
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:29:
          276|       (index: dep:
          277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
             |                             ^
          278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep

       … from call site
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:12:
          276|       (index: dep:
          277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
             |            ^
          278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep

       … while calling 'isDerivation'
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/attrsets.nix:1249:5:
         1248|   isDerivation =
         1249|     value: value.type or null == "derivation";
             |     ^
         1250|

       … while calling the 'elemAt' builtin
         at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/lists.nix:334:43:
          333|   */
          334|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
             |                                           ^
          335|

       error: undefined variable 'gcc14'
       at /nix/store/p30m636dj2ibjqlq4xwlgy6jqjy6ywws-source/flake.nix:40:64:
           39|
           40|         nativeBuildInputs = with pkgs; [pkg-config meson ninja gcc14];
             |                                                                ^
           41|         buildInputs = with pkgs;
┏━ 1 Errors: 
 ⋮ 
┃          at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:69:
┃           276|       (index: dep:
┃           277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
┃              |                                                                     ^
┃           278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep
┃ 
┃        … in the left operand of the OR (||) operator
┃          at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:44:
┃           276|       (index: dep:
┃           277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
┃              |                                            ^
┃           278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep
┃ 
┃        … in the left operand of the OR (||) operator
┃          at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:29:
┃           276|       (index: dep:
┃           277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
┃              |                             ^
┃           278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep
┃ 
┃        … from call site
┃          at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/pkgs/stdenv/generic/make-derivation.nix:277:12:
┃           276|       (index: dep:
┃           277|         if isDerivation dep || dep == null || builtins.isString dep || builtins.isPath dep then dep
┃              |            ^
┃           278|         else if isList dep then checkDependencyList' ([index] ++ positions) name dep
┃ 
┃        … while calling 'isDerivation'
┃          at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/attrsets.nix:1249:5:
┃          1248|   isDerivation =
┃          1249|     value: value.type or null == "derivation";
┃              |     ^
┃          1250|
┃ 
┃        … while calling the 'elemAt' builtin
┃          at /nix/store/y45vqv6pa8bhgag1dw86rvi6rk55xhxn-source/lib/lists.nix:334:43:
┃           333|   */
┃           334|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
┃              |                                           ^
┃           335|
┃ 
┃        error: undefined variable 'gcc14'
┃        at /nix/store/p30m636dj2ibjqlq4xwlgy6jqjy6ywws-source/flake.nix:40:64:
┃            39|
┃            40|         nativeBuildInputs = with pkgs; [pkg-config meson ninja gcc14];
┃              |                                                                ^
┃            41|         buildInputs = with pkgs;
┣━━━                                                            
┗━ ∑ ⚠ Exited with 1 errors reported by nix at 22:45:06 after 6s
Error: 
   0: Failed to build configuration
   1: Command exited with status Exited(1)

Location:
   src/commands.rs:693