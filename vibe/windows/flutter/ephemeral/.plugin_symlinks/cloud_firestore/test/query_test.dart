// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import './mock.dart';

void main() {
  setupCloudFirestoreMocks();
  late FirebaseFirestore firestore;
  Query? query;

  group('$Query', () {
    setUpAll(() async {
      await Firebase.initializeApp();
      // secondary app
      await Firebase.initializeApp(
        name: 'foo',
        options: const FirebaseOptions(
          apiKey: '123',
          appId: '123',
          messagingSenderId: '123',
          projectId: '123',
        ),
      );

      firestore = FirebaseFirestore.instance;
    });

    setUp(() {
      // Reset the query before each test
      query = firestore.collection('foo');
    });

    test('.limit() throws if limit is negative', () {
      expect(() => query!.limit(0), throwsAssertionError);
      expect(() => query!.limitToLast(-1), throwsAssertionError);
    });

    group('.where()', () {
      test('throws if field is invalid', () {
        expect(() => query!.where(123), throwsAssertionError);
      });

      test('allows multiple inequalities on different paths is provided', () {
        query!
            .where('foo.bar', isGreaterThanOrEqualTo: 123)
            .where('bar', isLessThan: 123);
      });

      test('allows inequality on the same path', () {
        query!
            .where('foo.bar', isGreaterThan: 123)
            .where('foo.bar', isGreaterThan: 1234);
      });

      test('throw an exception when making query combining `in` & `not-in`',
          () {
        expect(
          () => query!.where('number', whereIn: [1, 2], whereNotIn: [3, 4]),
          throwsAssertionError,
        );

        expect(
          () => query!.where('number', whereIn: [1, 2]).where(
            'number',
            whereNotIn: [3, 4],
          ),
          throwsAssertionError,
        );

        expect(
          () => query!.where('number', whereNotIn: [3, 4]).where(
            'number',
            whereIn: [1, 2],
          ),
          throwsAssertionError,
        );
      });

      test('allows inequality  different to first orderBy', () {
        query!.where('foo', isGreaterThan: 123).orderBy('bar');
        query!.orderBy('bar').where('foo', isGreaterThan: 123);
        query!.where('foo', isGreaterThan: 123).orderBy('bar').orderBy('foo');
        query!.orderBy('bar').orderBy('foo').where('foo', isGreaterThan: 123);
        query!.where(FieldPath.documentId, whereNotIn: ['bar']).orderBy('foo');
        query!.where(FieldPath.documentId, isLessThan: 3).orderBy('foo');
        query!.where(FieldPath.documentId, isGreaterThan: 3).orderBy('foo');
        query!.where('foo', whereNotIn: ['bar']).orderBy('baz');
        query!.where('foo', isLessThan: 3).orderBy('bar');
        query!.where('foo', isGreaterThan: 3).orderBy('bar');
      });

      test('throws if whereIn query length is greater than 30', () {
        List<int> numbers = List.generate(31, (i) => i + 1);
        expect(
          () => query!.where('foo.bar', whereIn: numbers),
          throwsAssertionError,
        );
      });

      test('throws if arrayContainsAny query length is greater than 30', () {
        List<int> numbers = List.generate(31, (i) => i + 1);
        expect(
          () => query!.where(
            'foo',
            arrayContainsAny: numbers,
          ),
          throwsAssertionError,
        );
      });

      test('throws if whereNotIn query length is greater than 10', () {
        expect(
          () => query!.where(
            'foo',
            whereNotIn: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
          ),
          throwsAssertionError,
        );
      });

      test('throws if empty array used for whereIn filters', () {
        expect(() => query!.where('foo', whereIn: []), throwsAssertionError);
      });

      test('throws if empty array used for arrayContainsAny filters', () {
        expect(
          () => query!.where('foo', arrayContainsAny: []),
          throwsAssertionError,
        );
      });

      test('throws if multiple array filters in query', () {
        expect(
          () => query!
              .where('foo.bar', arrayContains: 1)
              .where('foo.bar', arrayContains: 2),
          throwsAssertionError,
        );
        expect(
          () => query!
              .where('foo.bar', arrayContains: 1)
              .where('foo.bar', arrayContainsAny: [2, 3]),
          throwsAssertionError,
        );
        expect(
          () => query!.where(
            'foo.bar',
            arrayContainsAny: [1, 2],
          ).where('foo.bar', arrayContains: 3),
          throwsAssertionError,
        );
      });

      test('throws if multiple disjunctive filters in query', () {
        expect(
          () => query!
              .where('foo', whereIn: [1, 2]).where('foo', whereIn: [2, 3]),
          throwsAssertionError,
        );
        expect(
          () => query!.where('foo', arrayContainsAny: [1]).where(
            'foo',
            arrayContainsAny: [2, 3],
          ),
          throwsAssertionError,
        );
        expect(
          () => query!
              .where('foo', whereIn: [2, 3])
              .where('foo', arrayContains: 1)
              .where('foo', arrayContainsAny: [2]),
          throwsAssertionError,
        );
        expect(
          () => query!.where('foo', arrayContains: 1).where(
            'foo',
            whereIn: [2, 3],
          ).where('foo', arrayContainsAny: [2]),
          throwsAssertionError,
        );
      });

      test(
          'throws if FieldPath.documentId field is used in conjunction with isNotEqualTo filter',
          () {
        expect(
          () => query!
              .where(FieldPath.documentId, isEqualTo: 'fake-id')
              .where('foo', isNotEqualTo: 'bar'),
          throwsAssertionError,
        );

        expect(
          () => query!
              .where('foo', isNotEqualTo: 'bar')
              .where(FieldPath.documentId, whereIn: [2, 3]),
          throwsAssertionError,
        );
      });

      test(
          'allow isNotEqualTo filter on FieldPath.documentId field & a different field on a separate filter',
          () {
        query!
            .where(FieldPath.documentId, isNotEqualTo: 'fake-id')
            .where(FieldPath.documentId, isEqualTo: 'another-fake-id')
            .where('foo', isNull: true);
      });

      test('allows arrayContains with whereIn filter', () {
        query!.where('foo', arrayContains: 1).where('foo', whereIn: [2, 3]);
        query!.where('foo', whereIn: [2, 3]).where('foo', arrayContains: 1);
        // cannot use more than one 'array-contains' or 'whereIn' filter
        expect(
          () => query!
              .where('foo', whereIn: [2, 3])
              .where('foo', arrayContains: 1)
              .where('foo', arrayContains: 2),
          throwsAssertionError,
        );
        expect(
          () => query!
              .where('foo', arrayContains: 1)
              .where('foo', whereIn: [2, 3]).where('foo', whereIn: [2, 3]),
          throwsAssertionError,
        );
      });
    });

    group('cursor queries', () {
      test('throws if starting or ending point specified after orderBy', () {
        Query q = query!.orderBy('foo');
        expect(() => q.startAt([1]).orderBy('bar'), throwsAssertionError);
        expect(() => q.startAfter([1]).orderBy('bar'), throwsAssertionError);
        expect(() => q.endAt([1]).orderBy('bar'), throwsAssertionError);
        expect(() => q.endBefore([1]).orderBy('bar'), throwsAssertionError);
      });

      test('throws if inconsistent arguments number', () {
        expect(
          () => query!.orderBy('foo').startAt(['bar', 'baz']),
          throwsAssertionError,
        );
        expect(
          () => query!.orderBy('foo').startAfter(['bar', 'baz']),
          throwsAssertionError,
        );
        expect(
          () => query!.orderBy('foo').endAt(['bar', 'baz']),
          throwsAssertionError,
        );
        expect(
          () => query!.orderBy('foo').endBefore(['bar', 'baz']),
          throwsAssertionError,
        );
      });

      test('throws if fields are not a String or FieldPath', () {
        expect(() => query!.endAt([123, {}]), throwsAssertionError);
        expect(() => query!.startAt(['123', []]), throwsAssertionError);
        expect(() => query!.endBefore([true]), throwsAssertionError);
        expect(() => query!.startAfter([false]), throwsAssertionError);
      });

      test('throws if fields is greater than the number of orders', () {
        expect(() => query!.endAt(['123']), throwsAssertionError);
        expect(
          () => query!.startAt([
            FieldPath(const ['123']),
          ]),
          throwsAssertionError,
        );
      });

      test('endAt() replaces all end parameters', () {
        Query q = query!.orderBy('foo').endBefore(['123']);
        expect(q.parameters['endBefore'], equals(['123']));
        q = q.endAt(['456']);
        expect(q.parameters['endBefore'], isNull);
        expect(q.parameters['endAt'], equals(['456']));
      });
    });

    group('withConverter', () {
      test('overrides ==', () {
        final query = firestore.collection('/movies').limit(42);
        final query2 = firestore.collection('/movies').limit(21);

        int fromFirestore(Object? snapshot, Object? options) => 42;
        Map<String, Object?> toFirestore(Object? value, Object? options) => {};
        Map<String, Object?> intToFirestore(int value, Object? options) => {};

        expect(
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: intToFirestore,
          ),
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: intToFirestore,
          ),
        );

        expect(
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
        );
        expect(
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
          isNot(
            query.withConverter<Object?>(
              fromFirestore: fromFirestore,
              toFirestore: toFirestore,
            ),
          ),
        );
        expect(
          query.withConverter<Object?>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
          isNot(
            query.withConverter<int>(
              fromFirestore: fromFirestore,
              toFirestore: toFirestore,
            ),
          ),
        );
        expect(
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
          isNot(
            query2.withConverter<int>(
              fromFirestore: fromFirestore,
              toFirestore: toFirestore,
            ),
          ),
        );
        expect(
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
          isNot(
            query.withConverter<int>(
              fromFirestore: (_, __) => 21,
              toFirestore: toFirestore,
            ),
          ),
        );
        expect(
          query.withConverter<int>(
            fromFirestore: fromFirestore,
            toFirestore: toFirestore,
          ),
          isNot(
            query.withConverter<int>(
              fromFirestore: fromFirestore,
              toFirestore: (_, __) => {},
            ),
          ),
        );
      });
    });

    group('Settings()', () {
      test('Test the assert for setting `cacheSizeBytes` minimum and maximum',
          () {
        void configureCache(int? cacheSizeBytes) {
          assert(
            cacheSizeBytes == null ||
                cacheSizeBytes == Settings.CACHE_SIZE_UNLIMITED ||
                (cacheSizeBytes >= 1048576 && cacheSizeBytes <= 104857600),
            'Cache size, if specified, must be either CACHE_SIZE_UNLIMITED or between 1048576 bytes (inclusive) and 104857600 bytes (inclusive).',
          );
        }

        // Happy paths
        expect(() => configureCache(null), returnsNormally);
        expect(
          () => configureCache(Settings.CACHE_SIZE_UNLIMITED),
          returnsNormally,
        );
        expect(() => configureCache(5000000), returnsNormally);
        expect(() => configureCache(1048577), returnsNormally);
        expect(() => configureCache(104857600), returnsNormally);
        expect(() => configureCache(104857500), returnsNormally);

        // Assertion triggers
        expect(() => configureCache(1), throwsA(isA<AssertionError>()));
        expect(() => configureCache(1000), throwsA(isA<AssertionError>()));
        expect(() => configureCache(200000000), throwsA(isA<AssertionError>()));
        expect(() => configureCache(500000), throwsA(isA<AssertionError>()));
      });
    });
  });
}
