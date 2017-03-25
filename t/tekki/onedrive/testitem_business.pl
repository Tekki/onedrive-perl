# linebreaks and spaces added to JSON for better readability
(
  root => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdDateTime" : "2017-03-11T06:22:30Z",
  "id" : "01QNYR5IV6Y2GOVW7725BZO354PWSELRRZ",
  "lastModifiedDateTime" : "2017-03-24T18:43:11Z",
  "name" : "root",
  "webUrl" : "https://contoso-my.sharepoint.com/personal/tekki_contoso_onmicrosoft_com/Documents",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-11T06:22:30Z",
    "lastModifiedDateTime" : "2017-03-24T18:43:11Z"
  },
  "folder" : {
    "childCount" : 2
  },
  "root" : {},
  "size" : 996
}|
    ),
    content => {
      id      => '01QNYR5IV6Y2GOVW7725BZO354PWSELRRZ',
      ctag    => '',
      deleted => 0,
      etag    => '',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'root',
      lastmodified     => '2017-03-24T18:43:11Z',
      modifiedby       => '',
      name             => 'root',
      mtime            => '',
      package          => 0,
      parent_id        => '',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 1,
      sha1             => '',
      size             => 996,
    },
  },
  folder1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdDateTime" : "2017-03-24T18:19:47Z",
  "eTag" : "\"{A3768309-A2BD-4C72-8F38-7982F82E1A35},2\"",
  "id" : "01QNYR5IQJQN3KHPNCOJGI6ODZQL4C4GRV",
  "lastModifiedDateTime" : "2017-03-24T18:19:47Z",
  "name" : "First Folder",
  "webUrl" : "https://contoso-my.sharepoint.com/personal/tekki_contoso_onmicrosoft_com/Documents/First%20Folder",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-24T18:19:47Z",
    "lastModifiedDateTime" : "2017-03-24T18:19:47Z"
  },
  "folder" : {
    "childCount" : 2
  },
  "parentReference" : {
    "driveId" : "b!Ewo_rxEa0ga6p9o-ros1s3OqVKra_UDw5V5DLrDkFPVRI0LjLUjH",
    "id" : "01QNYR5IV6Y2GOVW7725BZO354PWSELRRZ",
    "path" : "/drive/root:"
  },
  "size" : 996
}|
    ),
    content => {
      id      => '01QNYR5IQJQN3KHPNCOJGI6ODZQL4C4GRV',
      ctag    => '',
      deleted => 0,
      etag    => '"{A3768309-A2BD-4C72-8F38-7982F82E1A35},2"',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'First Folder',
      lastmodified     => '2017-03-24T18:19:47Z',
      modifiedby       => '',
      name             => 'First Folder',
      mtime            => '',
      package          => 0,
      parent_id        => '01QNYR5IV6Y2GOVW7725BZO354PWSELRRZ',
      parent_path      => '',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 996,
    },
  },
  folder2 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdDateTime" : "2017-03-24T18:20:01Z",
  "eTag" : "\"{0861F6A6-8B94-40AA-B78D-D5E08ACC8D0E},2\"",
  "id" : "01QNYR5IVG6ZQQRFELVJALPDOV4CFMZDIO",
  "lastModifiedDateTime" : "2017-03-24T18:20:01Z",
  "name" : "Zentralbibliothek Z\u00fcrich",
  "webUrl" : "https://contoso-my.sharepoint.com/personal/tekki_contoso_onmicrosoft_com/Documents/First%20Folder/Zentralbibliothek%20Z%C3%BCrich",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-24T18:20:01Z",
    "lastModifiedDateTime" : "2017-03-24T18:20:01Z"
  },
  "folder" : {
    "childCount" : 1
  },
  "parentReference" : {
    "driveId" : "b!Ewo_rxEa0ga6p9o-ros1s3OqVKra_UDw5V5DLrDkFPVRI0LjLUjH",
    "id" : "01QNYR5IQJQN3KHPNCOJGI6ODZQL4C4GRV",
    "path" : "/drive/root:/First Folder"
  },
  "size" : 456
}|
    ),
    content => {
      id      => '01QNYR5IVG6ZQQRFELVJALPDOV4CFMZDIO',
      ctag    => '',
      deleted => 0,
      etag    => '"{0861F6A6-8B94-40AA-B78D-D5E08ACC8D0E},2"',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'First Folder/Zentralbibliothek Zürich',
      lastmodified     => '2017-03-24T18:20:01Z',
      modifiedby       => '',
      name             => 'Zentralbibliothek Zürich',
      mtime            => '',
      package          => 0,
      parent_id        => '01QNYR5IQJQN3KHPNCOJGI6ODZQL4C4GRV',
      parent_path      => 'First Folder',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 456,
    },
  },
  folder3 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdDateTime" : "2017-03-24T18:20:17Z",
  "eTag" : "\"{EC8406AD-D2D6-4878-A715-6A2F02731BF6},2\"",
  "id" : "01QNYR5IVNA2COZVWSPBEKOFLKF4BHGG7W",
  "lastModifiedDateTime" : "2017-03-24T18:20:17Z",
  "name" : "\u0420\u043e\u0441\u0441\u0438\u0439\u0441\u043a\u0430\u044f \u0433\u043e\u0441\u0443\u0434\u0430\u0440\u0441\u0442\u0432\u0435\u043d\u043d\u0430\u044f \u0431\u0438\u0431\u043b\u0438\u043e\u0442\u0435\u043a\u0430",
  "webUrl" : "https://contoso-my.sharepoint.com/personal/tekki_contoso_onmicrosoft_com/Documents/First%20Folder/%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B9%D1%81%D0%BA%D0%B0%D1%8F%20%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F%20%D0%B1%D0%B8%D0%B1%D0%BB%D0%B8%D0%BE%D1%82%D0%B5%D0%BA%D0%B0",
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-24T18:20:17Z",
    "lastModifiedDateTime" : "2017-03-24T18:20:17Z"
  },
  "folder" : {
    "childCount" : 1
  },
  "parentReference" : {
    "driveId" : "b!Ewo_rxEa0ga6p9o-ros1s3OqVKra_UDw5V5DLrDkFPVRI0LjLUjH",
    "id" : "01QNYR5IQJQN3KHPNCOJGI6ODZQL4C4GRV",
    "path" : "/drive/root:/First Folder"
  },
  "size" : 540
}|
    ),
    content => {
      id      => '01QNYR5IVNA2COZVWSPBEKOFLKF4BHGG7W',
      ctag    => '',
      deleted => 0,
      etag    => '"{EC8406AD-D2D6-4878-A715-6A2F02731BF6},2"',
      exists  => 0,
      exists_identical => 0,
      file             => 0,
      folder           => 1,
      full_path        => 'First Folder/Российская государственная библиотека',
      lastmodified     => '2017-03-24T18:20:17Z',
      modifiedby       => '',
      name             => 'Российская государственная библиотека',
      mtime            => '',
      package          => 0,
      parent_id        => '01QNYR5IQJQN3KHPNCOJGI6ODZQL4C4GRV',
      parent_path      => 'First Folder',
      quickxor         => '',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 540,
    },
  },
  file1 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdDateTime" : "2017-03-24T18:23:29Z",
  "eTag" : "\"{A0092AFB-30E5-4371-879F-4A9908637117},2\"",
  "id" : "01QNYR5IX3FIE2BZJQOFBYPH2KTEEGG4IX",
  "lastModifiedDateTime" : "2017-03-24T18:23:29Z",
  "name" : "\u00dcber uns.txt",
  "webUrl" : "https://contoso-my.sharepoint.com/personal/tekki_contoso_onmicrosoft_com/Documents/First%20Folder/Zentralbibliothek%20Z%C3%BCrich/%C3%9Cber%20uns.txt",
  "file" : {
    "hashes" : {
      "quickXorHash" : "gr+5bWt6heJUst7iz1uXq0kyGtQ="
    }
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-24T18:23:29Z",
    "lastModifiedDateTime" : "2017-03-24T18:23:29Z"
  },
  "parentReference" : {
    "driveId" : "b!Ewo_rxEa0ga6p9o-ros1s3OqVKra_UDw5V5DLrDkFPVRI0LjLUjH",
    "id" : "01QNYR5IVG6ZQQRFELVJALPDOV4CFMZDIO",
    "path" : "/drive/root:/First Folder/Zentralbibliothek Z\u00fcrich"
  },
  "size" : 456
}|
    ),
    content => {
      id      => '01QNYR5IX3FIE2BZJQOFBYPH2KTEEGG4IX',
      ctag    => '',
      deleted => 0,
      etag    => '"{A0092AFB-30E5-4371-879F-4A9908637117},2"',
      exists  => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'First Folder/Zentralbibliothek Zürich/Über uns.txt',
      lastmodified     => '2017-03-24T18:23:29Z',
      modifiedby       => '',
      name             => 'Über uns.txt',
      mtime            => '',
      package          => 0,
      parent_id        => '01QNYR5IVG6ZQQRFELVJALPDOV4CFMZDIO',
      parent_path      => 'First Folder/Zentralbibliothek Zürich',
      quickxor         => 'gr+5bWt6heJUst7iz1uXq0kyGtQ=',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 456,
    },
  },
  file2 => {
    json => decode_json(
      q|{
  "@odata.type" : "#microsoft.graph.driveItem",
  "createdDateTime" : "2017-03-24T18:21:47Z",
  "eTag" : "\"{1595D9CE-DE2F-42AC-8D16-E20193C839D4},2\"",
  "id" : "01QNYR5IWO3GKRKL66VRBI2FXCAGJ4QOOU",
  "lastModifiedDateTime" : "2017-03-24T18:21:47Z",
  "name" : "\u041d\u043e\u0432\u043e\u0441\u0442\u0438.txt",
  "webUrl" : "https://contoso-my.sharepoint.com/personal/tekki_contoso_onmicrosoft_com/Documents/First%20Folder/%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B9%D1%81%D0%BA%D0%B0%D1%8F%20%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F%20%D0%B1%D0%B8%D0%B1%D0%BB%D0%B8%D0%BE%D1%82%D0%B5%D0%BA%D0%B0/%D0%9D%D0%BE%D0%B2%D0%BE%D1%81%D1%82%D0%B8.txt",
  "file" : {
    "hashes" : {
      "quickXorHash" : "MFo7tZREc4M18lVQ7Rh5Q1Y/E20="
    }
  },
  "fileSystemInfo" : {
    "createdDateTime" : "2017-03-24T18:21:47Z",
    "lastModifiedDateTime" : "2017-03-24T18:21:47Z"
  },
  "parentReference" : {
    "driveId" : "b!Ewo_rxEa0ga6p9o-ros1s3OqVKra_UDw5V5DLrDkFPVRI0LjLUjH",
    "id" : "01QNYR5IVNA2COZVWSPBEKOFLKF4BHGG7W",
    "path" : "/drive/root:/First Folder/\u0420\u043e\u0441\u0441\u0438\u0439\u0441\u043a\u0430\u044f \u0433\u043e\u0441\u0443\u0434\u0430\u0440\u0441\u0442\u0432\u0435\u043d\u043d\u0430\u044f \u0431\u0438\u0431\u043b\u0438\u043e\u0442\u0435\u043a\u0430"
  },
  "size" : 540
}|
    ),
    content => {
      id      => '01QNYR5IWO3GKRKL66VRBI2FXCAGJ4QOOU',
      ctag    => '',
      deleted => 0,
      etag    => '"{1595D9CE-DE2F-42AC-8D16-E20193C839D4},2"',
      exists  => 0,
      exists_identical => 0,
      file             => 1,
      folder           => 0,
      full_path        => 'First Folder/Российская государственная библиотека/Новости.txt',
      lastmodified     => '2017-03-24T18:21:47Z',
      modifiedby       => '',
      name             => 'Новости.txt',
      mtime            => '',
      package          => 0,
      parent_id        => '01QNYR5IVNA2COZVWSPBEKOFLKF4BHGG7W',
      parent_path      => 'First Folder/Российская государственная библиотека',
      quickxor         => 'MFo7tZREc4M18lVQ7Rh5Q1Y/E20=',
      remote           => 0,
      root             => 0,
      sha1             => '',
      size             => 540,
    },
  },
);
