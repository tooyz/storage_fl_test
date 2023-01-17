import 'dart:async';

import 'package:storage_test/services/token_service/index.dart';

import 'services/storage_service/index.dart';

class TestRun {
  static run() async {
    StorageService? hiveImpl;
    StorageService? spImpl;

    const k1 = 'key1';
    const k2 = 'key2';

    const v1 = 'v1';
    const v2 = ['str'];

    prepare() async {
      print('prepare');
      hiveImpl = await StorageServiceManager.create();
      spImpl = await StorageServiceManager.create(false);

      await hiveImpl!.clear();
      await spImpl!.clear();
    }

    create() async {
      print('create');
      assert(hiveImpl!.backend == 'hive');
      assert(spImpl!.backend == 'shared_prefs');
    }

    write() async {
      print('write');
      final r1 = await hiveImpl!.write(k1, v1);
      final r2 = await spImpl!.write(k1, v1);
      final r3 = await hiveImpl!.write(k2, v2);
      final r4 = await spImpl!.write(k2, v2);

      assert(r1 == true);
      assert(r2 == true);
      assert(r3 == true);
      assert(r4 == true);
    }

    read() async {
      print('read');
      final r1 = await hiveImpl!.read(k1);
      final r2 = await spImpl!.read(k1);
      final r3 = await hiveImpl!.read(k2);
      final r4 = await spImpl!.read(k2);

      assert(r1 == v1);
      assert(r2 == v1);
      assert(r3 is List<String>);
      assert(r4 is List<String>);
    }

    delete() async {
      print('delete');
      await hiveImpl!.remove(k1);
      await spImpl!.remove(k1);

      const v = 'default';
      final r1 = await hiveImpl!.read(k1, defaultValue: v);
      final r2 = await spImpl!.read(k1, defaultValue: v);

      assert(r1 == v);
      assert(r2 == v);
    }

    clear() async {
      print('clear');
      final d1 = await hiveImpl!.clear();
      final d2 = await spImpl!.clear();

      final r1 = await hiveImpl!.read(k2);
      final r2 = await spImpl!.read(k2);

      assert(d1 == true);
      assert(d2 == true);

      assert(r1 == null);
      assert(r2 == null);
    }

    await prepare();
    await create();
    await write();
    await read();
    await delete();
    await clear();
    print('OK');
  }
}