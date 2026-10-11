// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCalendarEventModelCollection on Isar {
  IsarCollection<CalendarEventModel> get calendarEventModels =>
      this.collection();
}

const CalendarEventModelSchema = CollectionSchema(
  name: r'CalendarEventModel',
  id: 15124112474898114,
  properties: {
    r'alarmBeforeValue': PropertySchema(
      id: 0,
      name: r'alarmBeforeValue',
      type: IsarType.string,
    ),
    r'alarmDateTime': PropertySchema(
      id: 1,
      name: r'alarmDateTime',
      type: IsarType.dateTime,
    ),
    r'calendarDate': PropertySchema(
      id: 2,
      name: r'calendarDate',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'end': PropertySchema(
      id: 4,
      name: r'end',
      type: IsarType.dateTime,
    ),
    r'eventName': PropertySchema(
      id: 5,
      name: r'eventName',
      type: IsarType.string,
    ),
    r'isAlarmOpen': PropertySchema(
      id: 6,
      name: r'isAlarmOpen',
      type: IsarType.bool,
    ),
    r'repeatOption': PropertySchema(
      id: 7,
      name: r'repeatOption',
      type: IsarType.string,
    ),
    r'start': PropertySchema(
      id: 8,
      name: r'start',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _calendarEventModelEstimateSize,
  serialize: _calendarEventModelSerialize,
  deserialize: _calendarEventModelDeserialize,
  deserializeProp: _calendarEventModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _calendarEventModelGetId,
  getLinks: _calendarEventModelGetLinks,
  attach: _calendarEventModelAttach,
  version: '3.1.0+1',
);

int _calendarEventModelEstimateSize(
  CalendarEventModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.alarmBeforeValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.eventName.length * 3;
  bytesCount += 3 + object.repeatOption.length * 3;
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _calendarEventModelSerialize(
  CalendarEventModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alarmBeforeValue);
  writer.writeDateTime(offsets[1], object.alarmDateTime);
  writer.writeDateTime(offsets[2], object.calendarDate);
  writer.writeString(offsets[3], object.description);
  writer.writeDateTime(offsets[4], object.end);
  writer.writeString(offsets[5], object.eventName);
  writer.writeBool(offsets[6], object.isAlarmOpen);
  writer.writeString(offsets[7], object.repeatOption);
  writer.writeDateTime(offsets[8], object.start);
  writer.writeString(offsets[9], object.title);
}

CalendarEventModel _calendarEventModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CalendarEventModel();
  object.alarmBeforeValue = reader.readStringOrNull(offsets[0]);
  object.alarmDateTime = reader.readDateTimeOrNull(offsets[1]);
  object.calendarDate = reader.readDateTime(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.end = reader.readDateTime(offsets[4]);
  object.eventName = reader.readString(offsets[5]);
  object.id = id;
  object.isAlarmOpen = reader.readBool(offsets[6]);
  object.repeatOption = reader.readString(offsets[7]);
  object.start = reader.readDateTime(offsets[8]);
  object.title = reader.readStringOrNull(offsets[9]);
  return object;
}

P _calendarEventModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _calendarEventModelGetId(CalendarEventModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _calendarEventModelGetLinks(
    CalendarEventModel object) {
  return [];
}

void _calendarEventModelAttach(
    IsarCollection<dynamic> col, Id id, CalendarEventModel object) {
  object.id = id;
}

extension CalendarEventModelQueryWhereSort
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QWhere> {
  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CalendarEventModelQueryWhere
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QWhereClause> {
  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CalendarEventModelQueryFilter
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QFilterCondition> {
  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alarmBeforeValue',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alarmBeforeValue',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmBeforeValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmBeforeValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmBeforeValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmBeforeValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alarmBeforeValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alarmBeforeValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alarmBeforeValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alarmBeforeValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmBeforeValue',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmBeforeValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alarmBeforeValue',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alarmDateTime',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alarmDateTime',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmDateTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alarmDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmDateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alarmDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmDateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alarmDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      alarmDateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alarmDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      calendarDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calendarDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      calendarDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calendarDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      calendarDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calendarDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      calendarDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calendarDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      endEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'end',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      endGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'end',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      endLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'end',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      endBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'end',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eventName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eventName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventName',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      eventNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eventName',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      isAlarmOpenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAlarmOpen',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'repeatOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'repeatOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'repeatOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'repeatOption',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatOption',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      repeatOptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'repeatOption',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      startEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'start',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      startGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'start',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      startLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'start',
        value: value,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      startBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'start',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension CalendarEventModelQueryObject
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QFilterCondition> {}

extension CalendarEventModelQueryLinks
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QFilterCondition> {}

extension CalendarEventModelQuerySortBy
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QSortBy> {
  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByAlarmBeforeValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmBeforeValue', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByAlarmBeforeValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmBeforeValue', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByAlarmDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmDateTime', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByAlarmDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmDateTime', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByCalendarDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByCalendarDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByEventName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByEventNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByIsAlarmOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlarmOpen', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByIsAlarmOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlarmOpen', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByRepeatOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatOption', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByRepeatOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatOption', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension CalendarEventModelQuerySortThenBy
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QSortThenBy> {
  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByAlarmBeforeValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmBeforeValue', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByAlarmBeforeValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmBeforeValue', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByAlarmDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmDateTime', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByAlarmDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alarmDateTime', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByCalendarDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByCalendarDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByEventName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByEventNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventName', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByIsAlarmOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlarmOpen', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByIsAlarmOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAlarmOpen', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByRepeatOption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatOption', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByRepeatOptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatOption', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.desc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension CalendarEventModelQueryWhereDistinct
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct> {
  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByAlarmBeforeValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmBeforeValue',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByAlarmDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alarmDateTime');
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByCalendarDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calendarDate');
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'end');
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByEventName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByIsAlarmOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAlarmOpen');
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByRepeatOption({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatOption', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'start');
    });
  }

  QueryBuilder<CalendarEventModel, CalendarEventModel, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension CalendarEventModelQueryProperty
    on QueryBuilder<CalendarEventModel, CalendarEventModel, QQueryProperty> {
  QueryBuilder<CalendarEventModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CalendarEventModel, String?, QQueryOperations>
      alarmBeforeValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmBeforeValue');
    });
  }

  QueryBuilder<CalendarEventModel, DateTime?, QQueryOperations>
      alarmDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alarmDateTime');
    });
  }

  QueryBuilder<CalendarEventModel, DateTime, QQueryOperations>
      calendarDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calendarDate');
    });
  }

  QueryBuilder<CalendarEventModel, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CalendarEventModel, DateTime, QQueryOperations> endProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'end');
    });
  }

  QueryBuilder<CalendarEventModel, String, QQueryOperations>
      eventNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventName');
    });
  }

  QueryBuilder<CalendarEventModel, bool, QQueryOperations>
      isAlarmOpenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAlarmOpen');
    });
  }

  QueryBuilder<CalendarEventModel, String, QQueryOperations>
      repeatOptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatOption');
    });
  }

  QueryBuilder<CalendarEventModel, DateTime, QQueryOperations> startProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'start');
    });
  }

  QueryBuilder<CalendarEventModel, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
